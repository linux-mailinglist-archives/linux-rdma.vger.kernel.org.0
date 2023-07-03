Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D807459EE
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jul 2023 12:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjGCKPa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jul 2023 06:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGCKP3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jul 2023 06:15:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88480196
        for <linux-rdma@vger.kernel.org>; Mon,  3 Jul 2023 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688379285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XvxK+fIsyjrDQkIYelBKm95I7W5xSKZhQqP3NKGrN5Y=;
        b=LrFYHwFYmSMTBCsFd60d4N/5RqATYE2ITQOgcTz5tplBff9TFKwacpN9Lg7GQz/9EoSIwb
        i8s/aI68qFS7+vH9hru0hDHVydOa1AxQYL1fcTzO9ukxPIaBnkXVPJSdm/NPk9M8WyMJAl
        euGbgNthqed0O5HbafKXk20WrwsNKYY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-VHZ1k2Z_NN60keo70AHzGw-1; Mon, 03 Jul 2023 06:14:44 -0400
X-MC-Unique: VHZ1k2Z_NN60keo70AHzGw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7672918d8a4so131000485a.0
        for <linux-rdma@vger.kernel.org>; Mon, 03 Jul 2023 03:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688379284; x=1690971284;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XvxK+fIsyjrDQkIYelBKm95I7W5xSKZhQqP3NKGrN5Y=;
        b=OSMXvQAxf8AcpEMRmVoEU5KMp/Pr0Z3cMoXd6RjDqkXVFo9dHqUrcHLrNjuVot7r0S
         kYGP2NrvZjfYmoKscgtIcod3wXRxkdlX10eFv8YFFcob0yZC/F59K0QKpMPLpvykFqbi
         b5fpvSXfyAR/zSjS4pLc4gWLkXuSG4J8Bgqc5v7Y8PlX989JXyB5fRCeVPsVpKzieUZZ
         Z+4Hhs372lfmmiNbKVmT7JOVUoyu2jNjRBtMsqerAPSjCYSt6L+n/jWJ9IWC+2c67H9i
         ljs8LVGPD+CMxcBLOdovk5wbUvQJ0KZONMC7xCPDuQIF1orYVGxc4GdwT9sxI8rAs7Iy
         9nGQ==
X-Gm-Message-State: ABy/qLaotUy3hirHwY5V1t1Ha2yF2kzZSP9T6mt2LmED2Nx09b9VMLs8
        B6HyH0Na1k/8mOmmgtJsy++ceLoKTP3PxpyhyIRxmQoDqoMNr4euBdl0QmnfBLIcvuF8/jgdQf5
        TKKZid1kzoFkWf3uXWPL/phCi4DCxLg==
X-Received: by 2002:a05:6214:202c:b0:625:aa48:e50f with SMTP id 12-20020a056214202c00b00625aa48e50fmr9437538qvf.6.1688379283895;
        Mon, 03 Jul 2023 03:14:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFljnv6+yTIgfMKV/gziFBD0PAF2l0MeOkDf4KoEbTfBbqyGgdTZozaiDNbKJUnLvyb6syUBw==
X-Received: by 2002:a05:6214:202c:b0:625:aa48:e50f with SMTP id 12-20020a056214202c00b00625aa48e50fmr9437518qvf.6.1688379283620;
        Mon, 03 Jul 2023 03:14:43 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-156.dyn.eolo.it. [146.241.247.156])
        by smtp.gmail.com with ESMTPSA id ec17-20020ad44e71000000b00632191a70a2sm11047509qvb.103.2023.07.03.03.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 03:14:42 -0700 (PDT)
Message-ID: <8fb0c81c022d58d3f08082764038d17cfc849ba1.camel@redhat.com>
Subject: Re: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
From:   Paolo Abeni <pabeni@redhat.com>
To:     Long Li <longli@microsoft.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Date:   Mon, 03 Jul 2023 12:14:37 +0200
In-Reply-To: <PH7PR21MB3263ED62B45BF78370350AD7CE28A@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
         <36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
         <PH7PR21MB3263B266E381BA15DCE45820CE25A@PH7PR21MB3263.namprd21.prod.outlook.com>
         <e5c3e5e5033290c2228bbad0307334a964eb065e.camel@redhat.com>
         <PH7PR21MB326330931CFDDA96E287E470CE2AA@PH7PR21MB3263.namprd21.prod.outlook.com>
         <2023063001-agenda-spent-83c6@gregkh>
         <PH7PR21MB3263330E6A32D81D52B955FBCE2AA@PH7PR21MB3263.namprd21.prod.outlook.com>
         <20230630163805.79c0bdf5@kernel.org>
         <PH7PR21MB3263ED62B45BF78370350AD7CE28A@PH7PR21MB3263.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, 2023-07-02 at 20:18 +0000, Long Li wrote:
> > > > > > > > Subject: Re: [Patch v3] net: mana: Batch ringing RX
> > > > > > > > queue
> > > > > > > > doorbell
> > > > > > > > on receiving
> > > > > > > > packets
> > > > > > > >=20
> > > > > > > > On Fri, 30 Jun 2023 20:42:28 +0000 Long Li wrote:
> > > > > > > > > > > > > > > > > > > > 5.15 and kernel 6.1. (those
> > > > > > > > > > > > > > > > > > > > kernels are longterm)
> > > > > > > > > > > > > > > > > > > > They need
> > > > > > > > > > > > > > > > > > > > this
> > > > > > > > > > > > > > > > > > > > fix to achieve the performance
> > > > > > > > > > > > > > > > > > > > target.
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > Why can't they be upgraded to get that
> > > > > > > > > > > > > > > > performance
> > > > > > > > > > > > > > > > target, and
> > > > > > > > > > > > > > > > all
> > > > > > > > > > > > > > > > the other goodness that those kernels
> > > > > > > > > > > > > > > > have? We don't
> > > > > > > > > > > > > > > > normally
> > > > > > > > > > > > > > > > backport new features, right?
> > > > > > > > > > > >=20
> > > > > > > > > > > > I think this should be considered as a fix, not
> > > > > > > > > > > > a new
> > > > > > > > > > > > feature.
> > > > > > > > > > > >=20
> > > > > > > > > > > > MANA is designed to be 200GB full duplex at the
> > > > > > > > > > > > start. Due
> > > > > > > > > > > > to
> > > > > > > > > > > > lack of
> > > > > > > > > > > > hardware testing capability at early stage of
> > > > > > > > > > > > the project,
> > > > > > > > > > > > we
> > > > > > > > > > > > could
> > > > > > > > > > > > only test 100GB for the Linux driver. When
> > > > > > > > > > > > hardware is
> > > > > > > > > > > > fully
> > > > > > > > > > > > capable
> > > > > > > > > > > > of reaching designed spec, this bug in the
> > > > > > > > > > > > Linux driver
> > > > > > > > > > > > shows up.
> > > > > > > >=20
> > > > > > > > That part we understand.
> > > > > > > >=20
> > > > > > > > If I were you I'd try to convince Greg and Paolo that
> > > > > > > > the
> > > > > > > > change is
> > > > > > > > small and
> > > > > > > > significant for user experience. And answer Greg's
> > > > > > > > question why
> > > > > > > > upgrading the
> > > > > > > > kernel past 6.1 is a challenge in your environment.
> > > >=20
> > > > I was under the impression that this patch was considered to be
> > > > a
> > > > feature,=20
> > > > not a bug fix. I was trying to justify that the "Fixes:" tag
> > > > was
> > > > needed.=20
> > > >=20
> > > > I apologize for misunderstanding this.
> > > >=20
> > > > Without this fix, it's not possible to run a typical workload
> > > > designed for 200Gb
> > > > physical link speed.
> > > >=20
> > > > We see a large number of customers and Linux distributions
> > > > committed
> > > > on 5.15=20
> > > > and 6.1 kernels. They planned the product cycles and
> > > > certification
> > > > processes=20
> > > > around these longterm kernel versions. It's difficult for them
> > > > to
> > > > upgrade to newer
> > > > kernel versions.

I think there are some misunderstanding WRT distros and stable kernels.
(Commercial) distros will backport the patch as needed, regardless such
patch landing in the 5.15 upstream tree or not. Individual users
running their own vanilla 5.15 kernel can't expect performance
improvement landing there.

All in all I feel undecided. I would endorse this change going trough
net-next (without the stable tag). I would feel less torn with this
change targeting -net without the stable tag. Targeting -net with the
stable tag sounds a bit too much to me.

Cheers,
Paolo

