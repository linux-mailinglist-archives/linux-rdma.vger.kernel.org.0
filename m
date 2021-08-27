Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7063F9CAF
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Aug 2021 18:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhH0QnV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Aug 2021 12:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhH0QnV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Aug 2021 12:43:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E82C061757
        for <linux-rdma@vger.kernel.org>; Fri, 27 Aug 2021 09:42:32 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e15so4272833plh.8
        for <linux-rdma@vger.kernel.org>; Fri, 27 Aug 2021 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N4ycuy1sr/uw7TD/lnGtmhJPET4O9tG56DU4s7vExRc=;
        b=Lvoj7e2n4w0IK4etf1iQ9jYZqI7qgmyxocAuTVCR51wfVsM28PORXBncAmMiSb0x3e
         gXKO8JFv+/stlktlnaeDoUlxaVoGBLZ5ZsgHPfC5/Aq9HrdpUiYRUoQ/1+/0/BxOFR+v
         K7gYD0KPFk0KEAAWY5Vhx9xAHx7VlgBY6t7s6nltGRqP2xWwncovu6AsRkePywesuhRH
         a6NpkpoQ+YZzvrV0GkepU5Ky8P3+XdqHMZ7ivVQHBsSV9uGpJEoaucRLLVjyKgiib9do
         nAqnLT9d4hAmtf5EmyL014xAmvelwGeJ/AcSgrD+VM20kPD9NC+fd8o/hwnX0Fn7W45d
         8Xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4ycuy1sr/uw7TD/lnGtmhJPET4O9tG56DU4s7vExRc=;
        b=QUmOgoZepd7YiXYGWwgyD7oHVb3pKVZa+JIZBIpx6iN5pgh6Ed9xaQLdA+1cNS0Xrt
         MLUi9YvLg72xh9bKCSxL4hc3XmrojykgF1atoytnXa0CKbrLnzKVqRg6CQ6kFOi45wI4
         qomjQjCYk4xUn70PEoLN3W1a2HtoTF/yOUMaISy9GjlPcHZ0dP7Ws7JasiGFGh/jOh3p
         uKPzVvaLpr4sPb63ETsuL/I1BGI0VsvVN8+RlB3Fqni18xdjLARzIQbH8PBEGhm74Zm6
         heBIw629HtPnoH5noW4Rbb212ldQzvKeSwiFgH4GYwhYoe7YkJt4Os2gmPQRty9EcSGB
         nbDg==
X-Gm-Message-State: AOAM532xcQoF4mLr6TQhuEgZxeYCrX2DVRIW7f4xplm01DeOWrOAOdKo
        NeBw1HtxZWaqMqzEE4jamFlo4gL4uivCTRjEjixIAw==
X-Google-Smtp-Source: ABdhPJziK4HQfETlenNGQKDOWz+QE54n/rfbSQZA9GTYS/ZDxIcUoBcbFTG/U6SCP1KUl+Nf8+OpMuqzoNMp0yB/eFw=
X-Received: by 2002:a17:902:edd0:b0:135:b351:bd5a with SMTP id
 q16-20020a170902edd000b00135b351bd5amr9562085plk.52.1630082551867; Fri, 27
 Aug 2021 09:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <8b2514bb-1d4b-48bb-a666-85e6804fbac0@cn.fujitsu.com>
 <68169bc5-075f-8260-eedc-80fdf4b0accd@cn.fujitsu.com> <20210806014559.GM543798@ziepe.ca>
 <b5e6c4cd-8842-59ef-c089-2802057f3202@cn.fujitsu.com> <10c4bead-c778-8794-f916-80bf7ba3a56b@fujitsu.com>
 <20210827121034.GG1200268@ziepe.ca> <d276eeda-7f30-6c91-24cd-a40916fcc4c8@cn.fujitsu.com>
In-Reply-To: <d276eeda-7f30-6c91-24cd-a40916fcc4c8@cn.fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 27 Aug 2021 09:42:21 -0700
Message-ID: <CAPcyv4ho-42iZB3W5ypfwj-2=+v6rRUCcwE4ntPXyDPgFjzp7g@mail.gmail.com>
Subject: Re: RDMA/rpma + fsdax(ext4) was broken since 36f30e486d
To:     "Li, Zhijian" <lizhijian@cn.fujitsu.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        Yishai Hadas <yishaih@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 27, 2021 at 6:05 AM Li, Zhijian <lizhijian@cn.fujitsu.com> wrote:
>
>
> on 2021/8/27 20:10, Jason Gunthorpe wrote:
> > On Fri, Aug 27, 2021 at 08:15:40AM +0000, lizhijian@fujitsu.com wrote:
> >> i looked over the change-log of hmm_vma_handle_pte(), and found that before
> >> 4055062 ("mm/hmm: add missing call to hmm_pte_need_fault in HMM_PFN_SPECIAL handling")
> >>
> >> hmm_vma_handle_pte() will not check pte_special(pte) if pte_devmap(pte) is true.
> >>
> >> when we reached
> >> "if (pte_special(pte) && !is_zero_pfn(pte_pfn(pte))) {"
> >> the pte have already presented and its pte's flag already fulfilled the request flags.
> >>
> >>
> >> My question is that
> >> Per https://01.org/blogs/dave/2020/linux-consumption-x86-page-table-bits,
> >> pte_devmap(pte) and pte_special(pte) could be both true in fsdax user case, right ?
> > How? what code creates that?
> >
> > I see:
> >
> > insert_pfn():
> >       /* Ok, finally just insert the thing.. */
> >       if (pfn_t_devmap(pfn))
> >               entry = pte_mkdevmap(pfn_t_pte(pfn, prot));
> >       else
> >               entry = pte_mkspecial(pfn_t_pte(pfn, prot));
> >
> > So what code path ends up setting both bits?
>
>   pte_mkdevmap() will set both _PAGE_SPECIAL | PAGE_DEVMAP
>
>   395 static inline pte_t pte_mkdevmap(pte_t pte)
>   396 {
>   397         return pte_set_flags(pte, _PAGE_SPECIAL|_PAGE_DEVMAP);
>   398 }

I can't recall why _PAGE_SPECIAL is there. I'll take a look, but I
think setting _PAGE_SPECIAL in pte_mkdevmap() is overkill.
