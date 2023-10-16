Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBA57CA7C5
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Oct 2023 14:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJPML2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Oct 2023 08:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJPML1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Oct 2023 08:11:27 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7888E
        for <linux-rdma@vger.kernel.org>; Mon, 16 Oct 2023 05:11:25 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7776f0d4187so2907885a.3
        for <linux-rdma@vger.kernel.org>; Mon, 16 Oct 2023 05:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697458285; x=1698063085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zAhnYVS9AcMapW7LntALoHk1EkUQiC0DxFM0b/5Rd9U=;
        b=djNrmfxEBBjFAcBz4Rp5hgailjICKQ7Wnk5HdKVbO39bsdwT9lxv25YC8+0m0NC1Af
         IpvtOhmO05CtkOb2MFFKeqlYXknJ5YqVMq9uAwSH2oM9UsSCh/Q/gwXdUMK/4DRfkuTv
         cG5fWDptyr0gF+J9XC7xvchZ6YkwiemZSvTaVUA9Cj25bp3GiNhnXMK2gTYgqHeENRmI
         Eco65kaCoPNCPFANtqmMX4D50FQwqNxCTMEEMf0b0mcBoctO4WMjNQYU8RBses0Is7An
         TCREBF6fdL7l5Zje9OGYWlP96Dt9fgy6+SFK10/YUi7Vo5q3iaYBCEgleOT40VWiJz75
         i8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697458285; x=1698063085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAhnYVS9AcMapW7LntALoHk1EkUQiC0DxFM0b/5Rd9U=;
        b=HSlV0A1y2Sgi4xQnup4Mkr3yA/5jji3ApJIhS9OoKuhdBPuDs6lGV/OkjJYxLmQyWE
         xwzoFIEvQkoyVmPqBez91G7sWQb23u3ERz/D/WK5MFhRujdGnns1jmvAUjcne24uqyYu
         eqaaaREuaaEnmK6sxrKklf2GhlxlSJWHJ79dyJP8VOje9nJI/xyFLldop2cA9RlfHcUI
         nPaV3otKeH1kJgTaJ0QZPrY6n2vlRwLi7ezrBPDJnbjPUMx1biDk/WV2eDac9yB3trbs
         Yhp6ubinVfZ7OUrnU99vV8Pq3in0HX1U9GKRjgQajYtsYeWJ84t0Vsd/a4dKI0S8RPht
         +nzQ==
X-Gm-Message-State: AOJu0YzolyahDGhRwZR6jlJxUSptkgvJdvdThfEDhrniE78wjKaDAQRn
        zywfYzcRgtygaqbQm1VVrLkf1g==
X-Google-Smtp-Source: AGHT+IGK2mfYjjZO9zCSPm/Y/SLBTahUJDKWRTidQRGGn9DlssoXWzD7+gB4ys64smmeEZzJWW6FIw==
X-Received: by 2002:a05:620a:21cc:b0:76f:1e31:93cd with SMTP id h12-20020a05620a21cc00b0076f1e3193cdmr33832505qka.43.1697458284945;
        Mon, 16 Oct 2023 05:11:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id e5-20020a05620a12c500b007756c8ce8f5sm2919094qkl.59.2023.10.16.05.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 05:11:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qsMRP-001mtq-4i;
        Mon, 16 Oct 2023 09:11:23 -0300
Date:   Mon, 16 Oct 2023 09:11:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     Markus Armbruster <armbru@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "quintela@redhat.com" <quintela@redhat.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 39/52] migration/rdma: Convert qemu_rdma_write_one() to
 Error
Message-ID: <20231016121123.GD282036@ziepe.ca>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-40-armbru@redhat.com>
 <9e117d0c-cf2b-dd01-7fef-55d1c41d254c@fujitsu.com>
 <b8f8ed5d-f20e-4309-f29c-960321ecad83@fujitsu.com>
 <87ttrhgu9e.fsf@pond.sub.org>
 <87zg17dejj.fsf@pond.sub.org>
 <9a9ac53b-e409-3b87-ea1b-e133903828a5@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a9ac53b-e409-3b87-ea1b-e133903828a5@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 07, 2023 at 03:40:50AM +0000, Zhijian Li (Fujitsu) wrote:
> +rdma-core
> 
> 
> Is global variable *errno* reliable when the documentation only states
> "returns 0 on success, or the value of errno on failure (which indicates the failure reason)."

I think the intention of this language was that an errno constant is
returned, the caller should not assume it is stored in errno.

errno is difficult, many things overwrite it, you can loose its value
during error handling.

Jason
