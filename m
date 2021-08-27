Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EBA3F996C
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Aug 2021 15:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241291AbhH0NRs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Aug 2021 09:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbhH0NRs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Aug 2021 09:17:48 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B1CC0613CF
        for <linux-rdma@vger.kernel.org>; Fri, 27 Aug 2021 06:16:59 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 22so7106244qkg.2
        for <linux-rdma@vger.kernel.org>; Fri, 27 Aug 2021 06:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Zqlt5DZ1Ie+aRGdbfLW2zyrhesPZ9ELRKv5093QWQzY=;
        b=A8ot+uWHG4LrZwrNa6kGY0narHhP5ggNFnjAilhm8jZpcFm2ioqX3LcFxnsDJVt+FF
         VvwQHbSZ/tCYA9lxuRmw5JO/KG7fMKAy01yLLAFO7fGw709UTjqRb1x86xGkPUFNuJzO
         lDrAyqzzI8iJaHo2YbTxMEbUjJc0lRCsEvMng/sjHvrqTRjS1MN6ky/CSWSIQZkh6wjV
         +qZ/1eRUZ5Sh1aab6QVbWBdk283G9EnO+/SXrg7Ci+I3HvEE4x3EFW/KiFn+49mx8zlj
         HyxScQm9yiId27Su4Pun7/2Kk6MZAGLpFMqN9FE+pt2L8XPClmEy7ph+tQ91sf2tcVl0
         69WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Zqlt5DZ1Ie+aRGdbfLW2zyrhesPZ9ELRKv5093QWQzY=;
        b=bKGUqGvrOiPoatJBJrh/yZbHbPLe+JC8Hr7cR4wYxJIL8CgYo7OjKVZZPUFhwsRWd1
         04FL50dpknlpnCIMxw+uuTut7M+8LAljewU49YoWnkhT8BYNxVpI920o9e953fqUrfXa
         kQ6KKn9XjwrZcTKl90TzdgOJE3xDvCm0Sz/HEqbry7zbrjpi6sUkDl+l+ea8YCV7ga36
         WjaRCsqhbcQKV7+2PJEwCsvZNCsTFFYbKBD6iPL4CFeK95l8sLc0jLe2B/SdZkWRNIYX
         pQDBjuaxfoIZtW0UMZmL+tlEqF6k/FbLy+29p6fRm7UeORlBW5saGAxlQb2PnYGSZj6H
         emGA==
X-Gm-Message-State: AOAM5337iJq0D02GKuqmV5ogp1SLjQm1FU+l+hseUc8G7ORQZi7lLjPg
        /s0jj371IhfSnOrkxe+sa7NFYw==
X-Google-Smtp-Source: ABdhPJwTXS6LDXSWwyXTzKjKsscU+JjEZ5464lBBMs/dmejvN86JgWQ5uX9I9OQt4qJNt460/Ct+Lg==
X-Received: by 2002:a05:620a:1210:: with SMTP id u16mr8837124qkj.390.1630070218370;
        Fri, 27 Aug 2021 06:16:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id w18sm3322867qto.91.2021.08.27.06.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 06:16:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mJbj7-005giR-Ak; Fri, 27 Aug 2021 10:16:57 -0300
Date:   Fri, 27 Aug 2021 10:16:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Li, Zhijian" <lizhijian@cn.fujitsu.com>
Cc:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        Yishai Hadas <yishaih@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: Re: RDMA/rpma + fsdax(ext4) was broken since 36f30e486d
Message-ID: <20210827131657.GI1200268@ziepe.ca>
References: <8b2514bb-1d4b-48bb-a666-85e6804fbac0@cn.fujitsu.com>
 <68169bc5-075f-8260-eedc-80fdf4b0accd@cn.fujitsu.com>
 <20210806014559.GM543798@ziepe.ca>
 <b5e6c4cd-8842-59ef-c089-2802057f3202@cn.fujitsu.com>
 <10c4bead-c778-8794-f916-80bf7ba3a56b@fujitsu.com>
 <20210827121034.GG1200268@ziepe.ca>
 <d276eeda-7f30-6c91-24cd-a40916fcc4c8@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d276eeda-7f30-6c91-24cd-a40916fcc4c8@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 27, 2021 at 09:05:21PM +0800, Li, Zhijian wrote:
> 
> on 2021/8/27 20:10, Jason Gunthorpe wrote:
> > On Fri, Aug 27, 2021 at 08:15:40AM +0000, lizhijian@fujitsu.com wrote:
> > > i looked over the change-log of hmm_vma_handle_pte(), and found that before
> > > 4055062 ("mm/hmm: add missing call to hmm_pte_need_fault in HMM_PFN_SPECIAL handling")
> > > 
> > > hmm_vma_handle_pte() will not check pte_special(pte) if pte_devmap(pte) is true.
> > > 
> > > when we reached
> > > "if (pte_special(pte) && !is_zero_pfn(pte_pfn(pte))) {"
> > > the pte have already presented and its pte's flag already fulfilled the request flags.
> > > 
> > > 
> > > My question is that
> > > Per https://01.org/blogs/dave/2020/linux-consumption-x86-page-table-bits,
> > > pte_devmap(pte) and pte_special(pte) could be both true in fsdax user case, right ?
> > How? what code creates that?
> > 
> > I see:
> > 
> > insert_pfn():
> > 	/* Ok, finally just insert the thing.. */
> > 	if (pfn_t_devmap(pfn))
> > 		entry = pte_mkdevmap(pfn_t_pte(pfn, prot));
> > 	else
> > 		entry = pte_mkspecial(pfn_t_pte(pfn, prot));
> > 
> > So what code path ends up setting both bits?
> 
>  pte_mkdevmap() will set both _PAGE_SPECIAL | PAGE_DEVMAP
> 
>  395 static inline pte_t pte_mkdevmap(pte_t pte)
>  396 {
>  397         return pte_set_flags(pte, _PAGE_SPECIAL|_PAGE_DEVMAP);
>  398 }
> 
> below is a calltrace example
> 
> [  400.728559] Call Trace:
> [  400.731595] dump_stack+0x6d/0x8b
> [  400.735536] insert_pfn+0x16c/0x180
> [  400.739596] __vm_insert_mixed+0x84/0xc0
> [  400.744144] dax_iomap_pte_fault+0x845/0x870
> [  400.749089] ext4_dax_huge_fault+0x171/0x1e0
> [  400.754096] __do_fault+0x31/0xe0
> [  400.758090]  ? pmd_devmap_trans_unstable+0x37/0x90
> [  400.763541] handle_mm_fault+0x11b1/0x1680
> [  400.768260] exc_page_fault+0x2f4/0x570
> [  400.772788]  ? asm_exc_page_fault+0x8/0x30
> [  400.777539]  asm_exc_page_fault+0x1e/0x30
> 
> 
> So is my previous change reasonable ?

Yes, can you send a proper patch and include the mm mailing list?

Jason
