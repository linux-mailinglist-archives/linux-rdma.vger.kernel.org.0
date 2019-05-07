Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04D8616ADF
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 21:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfEGTG0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 15:06:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40015 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfEGTGZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 15:06:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id k24so3177874qtq.7
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2019 12:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7jgRsI2s3ajSEK/gDpKUSjf1j97EOmpcHMelfW9vqsk=;
        b=A237T3zkGaYeQkvkfW2Va4v2CqKNAjZPs5ijRQOHOhR3UXROInhxJSODZbmf6WiwsH
         hIGTxRkV6An82xWH533ngBxAhfQzGdMxwJEOenYJXUeAxqSRgmGn6VtJ90O1LKQpXivp
         Utuenwkv5tkdOx2K6L5eDrAYTMwvTvS31ln5HVmLvGjGCLHm6XRRbUJQzJf9m8eedumP
         bnFONY775KgEgVAjZyHBf+22FdSjuSm1Ve06TWQ5CHaChEH6UskBHBvCSxMJi1oKe6+3
         U3JyyhzIMXsNvzcX8PcN0qcgyeH6GohrAkdpF3hcDKV+CJIK88fmxAfy95nzkrrQnbPI
         p0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7jgRsI2s3ajSEK/gDpKUSjf1j97EOmpcHMelfW9vqsk=;
        b=bIQFWHyrt92VxAi6Enke6TIFBxaacihmYqVbTGJKJkD4bo0IomfdmpW7lc8yyYXh/H
         NCZVE2Mu9b3o85cJ5/QRWcpcLoSUGthLvoMZrzNwY8wlobWIC/XMw2PYI36XyyxN9dnO
         Q5E+rmehk01eRvTBklvmcAwUoAzJ0we0lHpWz8FwWnHqZXMkVTVGdfvSAyrysk9XpZjA
         uvK8R94psp73ZzDfRSzjjTb5MAsNsHmvSAcFbv91moEn5vDAvNrE7o3eE6hEAhVW8Xiw
         ZJChPbS4RavXQqo/XbMY5PhDJY8YCr45NYt3IR1h0O7PdXNvPYAolDn/UPTbVUmztq6k
         Aqzg==
X-Gm-Message-State: APjAAAX/Tk2WkYAVh0YyMOUVSbUiGOh0A7ydgNn3Yx/26HGCmLJx4XBy
        TAMtcyD+xevC9u/FQSwa7O89Kg==
X-Google-Smtp-Source: APXvYqx3r7zcPEIfxolMQ50JsYjSvdJvRJzMp27zxRUs3y3pHAS7l2Ctv5Joa59v+BL9/u96qAbPWw==
X-Received: by 2002:aed:21c3:: with SMTP id m3mr28646974qtc.39.1557255984868;
        Tue, 07 May 2019 12:06:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id f1sm7327010qkc.50.2019.05.07.12.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 12:06:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hO5Pz-00084r-A4; Tue, 07 May 2019 16:06:23 -0300
Date:   Tue, 7 May 2019 16:06:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Michael Brooks <michael.brooks@intel.com>,
        Todd Rimmer <todd.rimmer@intel.com>
Subject: Re: [PATCH for-next] IB/core, ipoib: Do not overreact to SM LID
 change event
Message-ID: <20190507190623.GA31027@ziepe.ca>
References: <20190411142228.22587.63118.stgit@scvm10.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411142228.22587.63118.stgit@scvm10.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 11, 2019 at 07:22:35AM -0700, Dennis Dalessandro wrote:
> When IPoIB receives an SM LID change event, it reacts by flushing its
> path record cache and rejoining multicast groups. This is the same
> behavior it performs when it receives a reregistration event. This
> behavior is unnecessary as an SM may have database backup or
> synchronization mechanisms which permit the SM location or LID to change
> without loss of multicast membership and without impact to path records.
> 
> Both opensm and the OPA FM issue reregistration events if a new SM is
> started (or restarted with a new config) or an SM event occurs which
> results in loss of multicast membership records by the SM (such as
> opensm failover) or the SM encounters new nodes with Active ports (such
> as after joining 2 fabrics by connecting switches via ISLs). Hence this
> event can be depended on as the trigger for IPoIB cache and multicast
> flushing.
> 
> It appears that some drivers, such as qib, and hfi1 issue the
> IB_EVENT_SM_CHANGE but other drivers such as mlx4 and mlx5 do not.
> Empirical testing on Mellanox EDR using ibv_asyncwatch has confirmed
> that Mellanox EDR HCAs do not generate SM change events and that opensm
> does generate reregistration.
> 
> An SM LID change event is generated by the mentioned drivers to reflect
> that sm_lid and/or sm_sl in the local port info has changed. The intent
> of this event is to permit applications and ULPs which have a local copy
> of this information (or an address handle using it) to update their
> information.
> 
> The intent is that the reregistration event (caused by the SM via a bit
> in Set(PortInfo)) be used to inform nodes that they need to rejoin
> multicast groups, resubscribe for notices and potentially update path
> records.
> 
> When an SM migrates or fails over, a SM LID change event can occur. In
> response IPoIB discards path records and multicast membership and loses
> connectivity until these records are restored via SA requests. In very
> large fabrics, it may take minutes for the SM to be ready and for the SA
> responses to be supplied.  This can result in undesirable and
> unnecessary IPoIB connectivity impacts. It also can result in an
> unnecessary storm of SA queries from all nodes in a cluster potentially
> followed by yet another storm if the SM issues the reregistration
> request.
> 
> The fact the Mellanox HCAs do not even generate this event, is further
> evidence that on modern IB fabrics there will be no ill side effects
> from the proposed changes below to reduce the reaction by 3 kernel
> components to this event. So these changes should be benign for Mellanox
> IB fabrics and will benefit OPA fabrics while also making ib_core and
> ULP behavor "correct" as intended by the IBTA spec and kernel RDMA event
> APIs.
> 
> Address these issues by removing IB_EVENT_SM_CHANGE handling from ipoib.
> IPoIB does not locally store sm_lid nor sm_sl, so it does not need to do
> anything on SM LID change. IPoIB makes use of other ib_core components
> to issue SA requests for it and those components correctly track SM LID
> and SM LID changes.
> 
> Also in ib_core multicast handling,  remove the test for
> IB_EVENT_SM_CHANGE. This code is moving all multicast groups to the
> error state, which will trigger rejoins. This code is used by IPoIB as
> well as the connection manager and other clients of multicast groups.
> This kernel module centralizes group membership status and joins since a
> node can only join a given group once but multiple ULPs or applications
> may want to join the same group. It makes use of the sa_query.c
> component in ib_core, which correctly trackes SM LID and SL. This
> component does not track SM LID nor SL itself and hence need not react
> to their changes.
> 
> Similarly in the ib_core cache code remove the handling for the
> IB_EVENT_SM_CHANGE.  In this function. The ib_cache_update function
> which is ultimately called is updating local copies of the pkey table,
> gid table and lmc. It does not update nor retain sm_lid nor sm_sl. As
> such it does not need to be called on an SM LID change. It technically
> also does not need to be called on a reregistration. The LID_CHANGE,
> PKEY_CHANGE, GID_CHANGE and port state change events (PORT_ERR,
> PORT_ACTICE) should be sufficient triggers.
> 
> It is worth noting that the alternative of simply having the hfi1 and
> qib drivers not generate the SM LID change event was explored. While
> this would duplicate what Mellanox drivers do now, it is not the correct
> behavior and removes the ability for an SM to migrate without requiring
> reregistration. Since both opensm and OPA SM have mechanisms to backup
> or synchronize registration information, it is desirable to let them
> perform SM migrations (with LID or SL changes) without requiring
> reregistration when they deem it appropriate.
> 
> Suggested-by: Todd Rimmer <todd.rimmer@intel.com>
> Tested-by: Michael Brooks <michael.brooks@intel.com>
> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Reviewed-by: Todd Rimmer <todd.rimmer@intel.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/core/cache.c            |    1 -
>  drivers/infiniband/core/multicast.c        |    1 -
>  drivers/infiniband/ulp/ipoib/ipoib_verbs.c |    3 +--
>  3 files changed, 1 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
