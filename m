Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D8C3A9AAC
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 14:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhFPMqK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 08:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232628AbhFPMqJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 08:46:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B59AF61166;
        Wed, 16 Jun 2021 12:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623847443;
        bh=3w2R8A0z9dkpFySB0GblcZy473wM3o3AaZfzRY6cB+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r6IPT15PPQFmwUJYlA2CUFF/MfXwtOLf2RRdJHfYbnk0vztxaLk49sjCkpc5ZKoNP
         SPW7/TFr57wVvHDYSaGB/k6dratBtb6QSzRKc7xA9ag6Bk7hK+knb/KV3wSMTNfqGA
         r/wRibtiraLjCJhyRls5tt/KEBgES0UT4Oc1647cFF6R9ZYm/HsAvaMz1Fv+DIYh3I
         ppG8Lc2M0+OSftbkrmF9Eq9bPYQepSmLXHhGEHAo2dNB/sbtjxnuarH1HRq32X//zP
         RM6XJ0MMJb8VTPQ0cCulcvEuQdru3eOpWjNF6MQWncztv9Oh4UaG7mdpGkCK/ZQB+O
         WhA9O0lOC6oJA==
Date:   Wed, 16 Jun 2021 15:43:59 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Anand Khoje <anand.a.khoje@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH v3 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices.
Message-ID: <YMnyD6oEiFv+p67T@unreal>
References: <20210609055534.855-4-anand.a.khoje@oracle.com>
 <YMB9gxlKbDvdynUE@unreal>
 <MWHPR1001MB2096CA7F29DCF86DE921903EC5369@MWHPR1001MB2096.namprd10.prod.outlook.com>
 <YMCakSCQLqUbcQ1H@unreal>
 <30CD8612-2030-44C1-A879-9A1EC668FC9C@oracle.com>
 <YMcEbBrDyDgmYEPu@unreal>
 <CAEBEBEC-795E-4626-A842-2BD156EBB9FE@oracle.com>
 <YMg111mLzwqu8P0o@unreal>
 <427FB96F-2550-4106-B8AD-EC589C1FD82B@oracle.com>
 <76766414-4D50-4E60-B3FC-1989026562D9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76766414-4D50-4E60-B3FC-1989026562D9@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 16, 2021 at 11:20:01AM +0000, Haakon Bugge wrote:
> 
> 
> > On 15 Jun 2021, at 18:13, Haakon Bugge <haakon.bugge@oracle.com> wrote:
> > 
> > 
> > 
> >> On 15 Jun 2021, at 07:08, Leon Romanovsky <leon@kernel.org> wrote:
> >> 
> >> On Mon, Jun 14, 2021 at 04:29:09PM +0000, Haakon Bugge wrote:
> >>> 
> >>> 
> >>>> On 14 Jun 2021, at 09:25, Leon Romanovsky <leon@kernel.org> wrote:
> >>>> 
> >>>> On Mon, Jun 14, 2021 at 03:32:39AM +0000, Haakon Bugge wrote:
> >>>>> 
> >>>>> 
> >>>>>> On 9 Jun 2021, at 12:40, Leon Romanovsky <leon@kernel.org> wrote:
> >>>>>> 
> >>>>>> On Wed, Jun 09, 2021 at 09:26:03AM +0000, Anand Khoje wrote:
> >>>>>>> Hi Leon,
> >>>>>> 
> >>>>>> Please don't do top-posting.
> >>>>>> 
> >>>>>> 
> >>>>>>> 
> >>>>>>> The set_bit()/clear_bit() and enum ib_port_data_flags  has been added as a device that can be used for future enhancements. 
> >>>>>>> Also, usage of set_bit()/clear_bit() ensures the operations on this bit is atomic.
> >>>>>> 
> >>>>>> The bitfield variables are better suit this use case.
> >>>>>> Let's don't overcomplicate code without the reason.
> >>>>> 
> >>>>> The problem is always that people tend to build on what's in there. For example, look at the bitfields in rdma_id_private, tos_set,  timeout_set, and min_rnr_timer_set.
> >>>>> 
> >>>>> What do you think will happen when, let's say, rdma_set_service_type() and rdma_set_ack_timeout() are called in close proximity in time? There is no locking, and the RMW will fail intermittently.
> >>>> 
> >>>> We are talking about device initialization flow that shouldn't be
> >>>> performed in parallel to another initialization of same device, so the
> >>>> comparison to rdma-cm is not valid here.
> >>> 
> >>> I can agree to that. And it is probably not worthwhile to fix the bit-fields in rdma_id_private?
> >> 
> >> Before this article [1], I would say no, we don't need to fix.
> >> Now, I'm not sure about that.
> >> 
> >> "He also notes that even though the design flaws are difficult to exploit
> >> on their own, they can be combined with the other flaws found to make for
> >> a much more serious problem."
> >> 
> >> and 
> >> 
> >> "In other words, people did notice this vulnerability and a defense was standardized,
> >> but in practice the defense was never adopted. This is a good example that security
> >> defenses must be adopted before attacks become practical."
> > 
> > Let me send you a commit tomorrow. The last sentence you quoted above is ambiguous as far as I can understand. But the intention is clear though :-)
> 
> Do you prefer for-next or for-rc for this?

for-next, please.

Thanks

> 
> Thxs, Håkon
> 
