Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDDB633E7C
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 15:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiKVOH6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 09:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiKVOHa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 09:07:30 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C56668284
        for <linux-rdma@vger.kernel.org>; Tue, 22 Nov 2022 06:06:03 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id x21so10294313qkj.0
        for <linux-rdma@vger.kernel.org>; Tue, 22 Nov 2022 06:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s1NeuMFXBEcn7qVNMEy11cPUBFu3Uh/CN+zAZ2QB0G4=;
        b=dZOIDxRugRmuhmjKR0OXDlpibQ9g7OzZSTu5TtWGcOnGoVoiY7Y6qEoGp8700t0AFI
         HM5anMb6kq6IjenIG3WDlwgAROuLDAvmV/eAjxIA0fiKAOc0YnCDSjJZo9OfbltPDDj1
         phMQqtegrg16CWpvlnTRlgonoj0lp0g5TTLKnI45brjRkOAcXkilXxToMCp9LDMH7aAg
         Z39ZdxRDTknFUbZeZ1j+x84S3OT/hsmjfgySDIGJT/ugL4Jtbuo2r0Fyd6pDgr/eDmr0
         zsYXV4EQrw8fTnumR9doPHqZQtITNM6gM4BOiU+AAbCWTUhNBM4xg1wwNaZSUx+xmL60
         dSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1NeuMFXBEcn7qVNMEy11cPUBFu3Uh/CN+zAZ2QB0G4=;
        b=Wnh+iJq9/u7pjRfYrFwEPq0JhdhNHJqA/RBHFBG8ztJATynGvH2WqP60xkxoHJTR9l
         SRt8DEjUK8FBIpfoMjVqvVXM9IYLg6ovFt7ArwvBFHIfxAZCSyJ1XnuMO0EU2lblRYs0
         mTwpyhigi9AkiA7e4z7mSOWHgBO7YEJzsivWiadKE8dnbXHj44a4P3h4metOLleaS7F2
         w3vE3u66YIwHyPrEgfnF2iPYeCGQePYZmvSSWlhIayZGcLLx+MNkwyVXMJtSkGb62kQL
         ZW/jdlVZWeFIeQdHGtTa75OnkQL/L3TcliS9SFg+9y8/gUphm1YBUA6Nkz/qmBh182Rh
         9fxQ==
X-Gm-Message-State: ANoB5plmTEjjAC1OY0SnRBT67W98caHylJL2yh8TXY9xpbjWgSjJ7IpP
        fSmuvqSAEpdAMWe0Fu7dHqLwGcuVrMBIHg==
X-Google-Smtp-Source: AA0mqf6HCDOAywWAIuL63AjxSbrxhAlphtu/ShJX3uzC1hOdLJRxMyHLgnXYKixywLOcelQ9z6U6kw==
X-Received: by 2002:a05:620a:2225:b0:6fa:b73:812e with SMTP id n5-20020a05620a222500b006fa0b73812emr4983634qkh.433.1669125962104;
        Tue, 22 Nov 2022 06:06:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id p5-20020ac84605000000b003a55fe9f352sm8115029qtn.64.2022.11.22.06.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 06:06:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oxTuS-009jC3-KW;
        Tue, 22 Nov 2022 10:06:00 -0400
Date:   Tue, 22 Nov 2022 10:06:00 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [for-next PATCH 1/1] RDMA/rxe: sgt_append from ib_umem_get is
 not highmem
Message-ID: <Y3zXSK1Wb1/T7vx1@ziepe.ca>
References: <c806a812-4ecd-226f-109e-84642357fbcb@linux.dev>
 <20221120012939.539953-1-yanjun.zhu@intel.com>
 <Y3uZMQJgcNFDhq5L@ziepe.ca>
 <6cb433cb-c463-7cd8-ee5e-7e922733744a@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cb433cb-c463-7cd8-ee5e-7e922733744a@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 22, 2022 at 12:07:06PM +0800, Yanjun Zhu wrote:

> But can user space access these high memory? From "Understanding the Linux
> Kernel", third edition, it seems that it is in kernel space.

Yes, "highmem" is effecitvely the ability to have a struct page * that
is not mapped into the kernel address space, but is mapped into a
userspace process address sspace.

Jason
