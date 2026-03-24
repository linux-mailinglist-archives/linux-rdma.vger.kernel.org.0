Return-Path: <linux-rdma+bounces-18590-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPhQDJ4Aw2nRngQAu9opvQ
	(envelope-from <linux-rdma+bounces-18590-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 22:22:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EA031CCD6
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 22:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBADB3032F6B
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 21:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9219335E95E;
	Tue, 24 Mar 2026 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPxpDeHT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C4635C18C;
	Tue, 24 Mar 2026 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774387277; cv=none; b=PqyjDFW4Rtm7/yXnPznoHjgOpkun8nnnznD+hyI3l/G2Pl3AEmDlFy8L6jgwQb3pVrx78YL5hRo+0sTjCllzYucqsKkuUDGPpctPBfthLF8msPQKxj2YIUZ7Q5aG0ldgh4vao27JUJ35PvOxEVt+fw22hFAf7gqCm3SIwnonupM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774387277; c=relaxed/simple;
	bh=bN+zpILDmRdAJyoSgSd6M94WASWO6vtvLneiqPi/Tak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnJ1ttKaJogW/36+HpqlaDMquirYW8T7ejU/uVuoIKYYAHftAoBTm7tiYjPeSyxfY1gA6Gw343vV6SICd/TzYIWyY6iPXeMQmlXoxGdES6WEp96Z2IPfe/24I443pmXCowQA8YFSvaU62TIFSO0cLup3TP6bzHSloOSOcwwVVW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPxpDeHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467E9C19424;
	Tue, 24 Mar 2026 21:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774387276;
	bh=bN+zpILDmRdAJyoSgSd6M94WASWO6vtvLneiqPi/Tak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GPxpDeHTRLLHKaMrMRhB7HRNMR0vz+D407bx9zvLOnTJbqqZwfjcVWSbRqeltmaXk
	 U/jc0OvHw29QxROpi7/KR2iQfy/gTs99qOAsWHMNeSNW7mXTytQfOeJ0JePeYl8+9Y
	 GCQH2vtDTDe2fFdbFORXB7fmH9UwxKQz+2+rkstQ76DtCwx8tGXeTwO6ll7Vhv3WP/
	 PiD5yKwuyY3uLecx7KaywivjQshWNbFzJTYidBNzpT0X1/j9v+mpkubUwomd5VxAyV
	 i1ek+xmL0NpeY5k6srstmCNWYqifsJse7cXPJHy5VEo72hxrqBILALL0I1HJo7XGsI
	 esc9q6V430cAQ==
Date: Tue, 24 Mar 2026 14:21:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 andrew+netdev@lunn.ch, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
 johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
 dtatulea@nvidia.com, mohsin.bashr@gmail.com, jacob.e.keller@intel.com,
 willemb@google.com, skhawaja@google.com, bestswngs@gmail.com,
 aleksandr.loktionov@intel.com, kees@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH net-next v3 03/13] net: introduce ndo_set_rx_mode_async
 and dev_rx_mode_work
Message-ID: <20260324142114.216fcb01@kernel.org>
In-Reply-To: <acLUMN1BYkIVyOk8@mini-arch>
References: <20260320012501.2033548-1-sdf@fomichev.me>
	<20260320012501.2033548-4-sdf@fomichev.me>
	<20260323162003.0d155055@kernel.org>
	<acLUMN1BYkIVyOk8@mini-arch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18590-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fomichev.me,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[37];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C3EA031CCD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 11:13:04 -0700 Stanislav Fomichev wrote:
> > > +		netif_addr_lock_bh(dev);
> > > +
> > > +		err = __hw_addr_list_snapshot(&uc_snap, &dev->uc,
> > > +					      dev->addr_len);
> > > +		if (!err)
> > > +			err = __hw_addr_list_snapshot(&uc_ref, &dev->uc,
> > > +						      dev->addr_len);
> > > +		if (!err)
> > > +			err = __hw_addr_list_snapshot(&mc_snap, &dev->mc,
> > > +						      dev->addr_len);
> > > +		if (!err)
> > > +			err = __hw_addr_list_snapshot(&mc_ref, &dev->mc,
> > > +						      dev->addr_len);  
> > 
> > This doesn't get slow with a few thousands of addresses?  
> 
> I can add kunit benchmark and attach the output? Although not sure where
> to go from that. The alternative to this is allocating an array of entries.
> I started with that initially but __hw_addr_sync_dev wants to kfree the
> individual entries and I decided not to have a separate helpers to
> manage the snapshots.

Let's see what the benchmark says. Hopefully it's fast enough and 
we don't have to worry. Is keeping these lists around between the
invocations of the work tricky?

> > Can we give the work a reference on the netdev (at init time) and
> > cancel + release it here instead of flushing / waiting?  
> 
> Not sure why cancel+release, maybe you're thinking about the unregister
> path? This is rtnl_unlock -> netdev_run_todo -> __rtnl_unlock + some
> extras.
> 
> And the flush is here to plumb the addresses to the real devices
> before we return to the callers. Mostly because of the following
> things we have in the tests:
> 
> # TEST: team cleanup mode lacp                                        [FAIL]
> #       macvlan unicast address not found on a slave
> 
> Can you explain a bit more on the suggestion?

Oh, I thought it's here for unregister! Feels like it'd be cleaner to
add the flush in dev_*c_add() and friends? How hard would it be to
identify the callers in atomic context?

> > >  	/* Wait for rcu callbacks to finish before next phase */
> > >  	if (!list_empty(&list))
> > >  		rcu_barrier();
> > > @@ -12099,6 +12173,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
> > >  #endif
> > >  
> > >  	mutex_init(&dev->lock);
> > > +	INIT_WORK(&dev->rx_mode_work, dev_rx_mode_work);
> > >  
> > >  	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
> > >  	setup(dev);
> > > @@ -12203,6 +12278,8 @@ void free_netdev(struct net_device *dev)
> > >  
> > >  	kfree(rcu_dereference_protected(dev->ingress_queue, 1));
> > >  
> > > +	cancel_work_sync(&dev->rx_mode_work);  
> > 
> > Should never happen so maybe wrap it in a WARN ?  
> 
> Or maybe just flush_workqueue here as well? To signal the intent that we
> are mostly waiting for the wq entry to be unused to be able to kfree it?
> 


