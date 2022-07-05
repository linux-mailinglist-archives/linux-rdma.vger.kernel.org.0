Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22D9567064
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jul 2022 16:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiGEOJi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 10:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiGEOJY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 10:09:24 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2921E11A2C
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 06:58:56 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g14so13731661qto.9
        for <linux-rdma@vger.kernel.org>; Tue, 05 Jul 2022 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3US3MVCZchcdT6wOHaTrjCIK83okrRlI1rj7ODUMk38=;
        b=E430g6AtRsgOlE8YCa7YDcfutULa7X7121Je/c0X16KT5/eQlVRqJvhK57/165p4X+
         5KI15RlFTW1LCCB67b7kTmI8Sn40UgAIT/DfuWRnuL5BBvOJeNnSRltEuFqM0Sfbxxiz
         MXY85CsYlmu04hLKh3L5F0xcGpRpk3Lbr+6m7wocy+ofQec2Yat7J4uGBYo+iNoE54+C
         LL8NXpqdCVO/N2cf+lzUF1Bqh8RzmfMJm/pr2Np4sWta6YNKNGCnkrxDnr7A0bgCXcQa
         Wbno3nAG4mpXAZ6OcuY24STbLnY/IVu3wKXjynCoL4hKEOZS0zYwdkC3xwdJS5pIV2Nc
         ueBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3US3MVCZchcdT6wOHaTrjCIK83okrRlI1rj7ODUMk38=;
        b=TdQA8rBdnhS7JSiko8dnxjlmgxQ7hKZKYjuxRdfSsVIOHc+0ZfOaLn947yZHOM5sb0
         qTGWlzNpnJPp8+RGM19BhOc2UkJPJZ/TXUBjtLttOviykiEBhzBgIqi6OmtW9UFrniAZ
         Pn9TQKa+6Tq2kbCMbwAOOpS1bWFlwxFuCRs92+m1nRnDuPOY3ep6D1R9krCKZuRBzQ4K
         OS5i40Mh44cdVlFZv11RjB/jgObGrEYGk8A4itGCNzOPPrfH960u+jElgtJ+KnrGL+32
         7zLZpSlnfGhYqQd1/TWws6rk9RZv0T4UKQODtto62tHxnvx3xOPF5PJ9rTeLrY4c8qpe
         7g9w==
X-Gm-Message-State: AJIora/0eEru3TTsWHhaxalQ1n6ir2AE+Qss/KJPb8LvM3KKONcAEoGe
        eXYM8jiHP315pJQ+kicrMg3F8A==
X-Google-Smtp-Source: AGRyM1sTLLayHE8lxHdEbrXKwOpE8hs+06aG3jXrAaBA8b8ioDIpOJK5gxl1yd/SKYpXJQGy1+ubvQ==
X-Received: by 2002:a05:6214:4111:b0:472:f362:5a0f with SMTP id kc17-20020a056214411100b00472f3625a0fmr9341398qvb.23.1657029535335;
        Tue, 05 Jul 2022 06:58:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id g11-20020ac8480b000000b003051ba1f8bcsm21799768qtq.15.2022.07.05.06.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:58:54 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o8j4n-006VZF-TP; Tue, 05 Jul 2022 10:58:53 -0300
Date:   Tue, 5 Jul 2022 10:58:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org, rpearsonhpe@gmail.com,
        zyjzyj2000@gmail.com
Subject: Re: [PATCH 1/2] RDMA/rxe: Add common rxe_prepare_res()
Message-ID: <20220705135853.GF23621@ziepe.ca>
References: <20220705114603.6768-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705114603.6768-1-yangx.jy@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 05, 2022 at 07:46:02PM +0800, Xiao Yang wrote:
> Replace rxe_prepare_atomic_res() and rxe_prepare_read_res()
> with rxe_prepare_res().

Explain why we should do a change like this in the commit message
please

Jason
