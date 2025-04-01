Return-Path: <linux-rdma+bounces-9095-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B1EA782CB
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 21:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A4E16D7EB
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 19:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED1C1E7C01;
	Tue,  1 Apr 2025 19:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Um+/7vst";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5Hd9TpZa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Um+/7vst";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5Hd9TpZa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994E11D5151
	for <linux-rdma@vger.kernel.org>; Tue,  1 Apr 2025 19:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743535982; cv=none; b=WwelRcGSVT+PJNnCu/zYvipm0jGyfGTJ8yhOtLCZi8OjlSqCWKBqX/PAUs7mxsr/rI0l3iaYw2sTVDT+KHCWHZ5otQ4LWbY2knrvLbxT8VNTy6ANyR/7/+zUpg7idLRNSdHlSLaOnVuGSyoyvJrn9/sJLNrFee7fkkvrNKd1Pl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743535982; c=relaxed/simple;
	bh=W5HY2Uv6Mc50VbeAFeC9jsHF/DYzRrLTPvtRZw5gB38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k7BtazNnxvSCrPUYb7dq/baZe4wIaPsXY1eKX+aMUbAh3VhPrN4mMvLwnbvqqmRfkCad8c8+pGfpY0aEDcT8Vtcd8jMFsZgoHU/DCNgMoPVQ5jk8AYvXOn3xD0pLhcnPlFfEqgpyVfQ4D4tuiMv8tX+AeTt9xhwR9m/KlcuP2kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Um+/7vst; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5Hd9TpZa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Um+/7vst; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5Hd9TpZa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98DE51F38E;
	Tue,  1 Apr 2025 19:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743535978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0AqD+qdpv6islwITlr4suJBsdNlkf1+/1uY8htIMnyE=;
	b=Um+/7vstzCfwO/FEh5gdH6LV5MKEpVBgNSotP1JxVvhn99LtDUswIyyU+tjQVqzzqGjwvh
	37dP7gqrhEn+mK1RQYEWl3T910Ik2w4j0YzkfP8r0QjDJIl/xrNb8mNmKfILKZ35b5fVMe
	+GTSEgyivw2JvHqUadorRucpsmHBtSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743535978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0AqD+qdpv6islwITlr4suJBsdNlkf1+/1uY8htIMnyE=;
	b=5Hd9TpZaHa/HD9qg0AstxQaN6ybTNvMEW9DUIyUy374ZuPrcxLS6xFJLxf7tVF8gkHaxbl
	ki88YypH+O8Xn1Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Um+/7vst";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5Hd9TpZa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743535978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0AqD+qdpv6islwITlr4suJBsdNlkf1+/1uY8htIMnyE=;
	b=Um+/7vstzCfwO/FEh5gdH6LV5MKEpVBgNSotP1JxVvhn99LtDUswIyyU+tjQVqzzqGjwvh
	37dP7gqrhEn+mK1RQYEWl3T910Ik2w4j0YzkfP8r0QjDJIl/xrNb8mNmKfILKZ35b5fVMe
	+GTSEgyivw2JvHqUadorRucpsmHBtSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743535978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0AqD+qdpv6islwITlr4suJBsdNlkf1+/1uY8htIMnyE=;
	b=5Hd9TpZaHa/HD9qg0AstxQaN6ybTNvMEW9DUIyUy374ZuPrcxLS6xFJLxf7tVF8gkHaxbl
	ki88YypH+O8Xn1Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F58613691;
	Tue,  1 Apr 2025 19:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2yoeL2k/7GfbQgAAD6G6ig
	(envelope-from <farosas@suse.de>); Tue, 01 Apr 2025 19:32:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Jack Wang <jinpu.wang@ionos.com>, qemu-devel@nongnu.org, peterx@redhat.com
Cc: Li Zhijian <lizhijian@fujitsu.com>, Yu Zhang <yu.zhang@ionos.com>,
 linux-rdma@vger.kernel.org, michael@flatgalaxy.com, Michael Galaxy
 <mrgalaxy@nvidia.com>
Subject: Re: [PATCH] migration/rdma: Remove qemu_rdma_broken_ipv6_kernel
In-Reply-To: <20250327061123.14453-1-jinpu.wang@ionos.com>
References: <20250327061123.14453-1-jinpu.wang@ionos.com>
Date: Tue, 01 Apr 2025 16:32:55 -0300
Message-ID: <87cydvllso.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 98DE51F38E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Jack Wang <jinpu.wang@ionos.com> writes:

> I hit following error which testing migration in pure RoCE env:
> "-incoming rdma:[::]:8089: RDMA ERROR: You only have RoCE / iWARP devices in your
> systems and your management software has specified '[::]', but IPv6 over RoCE /
> iWARP is not supported in Linux.#012'."
>
> In our setup, we use rdma bind on ipv6 on target host, while connect from source
> with ipv4, remove the qemu_rdma_broken_ipv6_kernel, migration just work
> fine.
>
> Checking the git history, the function was added since introducing of
> rdma migration, which is more than 10 years ago. linux-rdma has
> improved support on RoCE/iWARP for ipv6 over past years. There are a few fixes
> back in 2016 seems related to the issue, eg:
> aeb76df46d11 ("IB/core: Set routable RoCE gid type for ipv4/ipv6 networks")
>
> other fixes back in 2018, eg:
> 052eac6eeb56 RDMA/cma: Update RoCE multicast routines to use net namespace
> 8d20a1f0ecd5 RDMA/cma: Fix rdma_cm raw IB path setting for RoCE
> 9327c7afdce3 RDMA/cma: Provide a function to set RoCE path record L2 parameters
> 5c181bda77f4 RDMA/cma: Set default GID type as RoCE when resolving RoCE route
> 3c7f67d1880d IB/cma: Fix default RoCE type setting
> be1d325a3358 IB/core: Set RoCEv2 MGID according to spec
> 63a5f483af0e IB/cma: Set default gid type to RoCEv2
>
> So remove the outdated function and it's usage.
>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Li Zhijian <lizhijian@fujitsu.com>
> Cc: Yu Zhang <yu.zhang@ionos.com>
> Cc: qemu-devel@nongnu.org
> Cc: linux-rdma@vger.kernel.org
> Cc: michael@flatgalaxy.com
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Tested-by: Li zhijian <lizhijian@fujitsu.com>
> Reviewed-by: Michael Galaxy <mrgalaxy@nvidia.com>
> ---
> v1: drop RFC, fix build error (zhijian), collect Reviewed-by and Tested-by
>
>  migration/rdma.c | 159 -----------------------------------------------
>  1 file changed, 159 deletions(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 76fb0349238a..e228520b8e01 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -767,149 +767,6 @@ static void qemu_rdma_dump_gid(const char *who, struct rdma_cm_id *id)
>      trace_qemu_rdma_dump_gid(who, sgid, dgid);
>  }
>  
> -/*
> - * As of now, IPv6 over RoCE / iWARP is not supported by linux.
> - * We will try the next addrinfo struct, and fail if there are
> - * no other valid addresses to bind against.
> - *
> - * If user is listening on '[::]', then we will not have a opened a device
> - * yet and have no way of verifying if the device is RoCE or not.
> - *
> - * In this case, the source VM will throw an error for ALL types of
> - * connections (both IPv4 and IPv6) if the destination machine does not have
> - * a regular infiniband network available for use.
> - *
> - * The only way to guarantee that an error is thrown for broken kernels is
> - * for the management software to choose a *specific* interface at bind time
> - * and validate what time of hardware it is.
> - *
> - * Unfortunately, this puts the user in a fix:
> - *
> - *  If the source VM connects with an IPv4 address without knowing that the
> - *  destination has bound to '[::]' the migration will unconditionally fail
> - *  unless the management software is explicitly listening on the IPv4
> - *  address while using a RoCE-based device.
> - *
> - *  If the source VM connects with an IPv6 address, then we're OK because we can
> - *  throw an error on the source (and similarly on the destination).
> - *
> - *  But in mixed environments, this will be broken for a while until it is fixed
> - *  inside linux.
> - *
> - * We do provide a *tiny* bit of help in this function: We can list all of the
> - * devices in the system and check to see if all the devices are RoCE or
> - * Infiniband.
> - *
> - * If we detect that we have a *pure* RoCE environment, then we can safely
> - * thrown an error even if the management software has specified '[::]' as the
> - * bind address.
> - *
> - * However, if there is are multiple hetergeneous devices, then we cannot make
> - * this assumption and the user just has to be sure they know what they are
> - * doing.
> - *
> - * Patches are being reviewed on linux-rdma.
> - */
> -static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
> -{
> -    /* This bug only exists in linux, to our knowledge. */
> -#ifdef CONFIG_LINUX
> -    struct ibv_port_attr port_attr;
> -
> -    /*
> -     * Verbs are only NULL if management has bound to '[::]'.
> -     *
> -     * Let's iterate through all the devices and see if there any pure IB
> -     * devices (non-ethernet).
> -     *
> -     * If not, then we can safely proceed with the migration.
> -     * Otherwise, there are no guarantees until the bug is fixed in linux.
> -     */
> -    if (!verbs) {
> -        int num_devices;
> -        struct ibv_device **dev_list = ibv_get_device_list(&num_devices);
> -        bool roce_found = false;
> -        bool ib_found = false;
> -
> -        for (int x = 0; x < num_devices; x++) {
> -            verbs = ibv_open_device(dev_list[x]);
> -            /*
> -             * ibv_open_device() is not documented to set errno.  If
> -             * it does, it's somebody else's doc bug.  If it doesn't,
> -             * the use of errno below is wrong.
> -             * TODO Find out whether ibv_open_device() sets errno.
> -             */
> -            if (!verbs) {
> -                if (errno == EPERM) {
> -                    continue;
> -                } else {
> -                    error_setg_errno(errp, errno,
> -                                     "could not open RDMA device context");
> -                    return -1;
> -                }
> -            }
> -
> -            if (ibv_query_port(verbs, 1, &port_attr)) {
> -                ibv_close_device(verbs);
> -                error_setg(errp,
> -                           "RDMA ERROR: Could not query initial IB port");
> -                return -1;
> -            }
> -
> -            if (port_attr.link_layer == IBV_LINK_LAYER_INFINIBAND) {
> -                ib_found = true;
> -            } else if (port_attr.link_layer == IBV_LINK_LAYER_ETHERNET) {
> -                roce_found = true;
> -            }
> -
> -            ibv_close_device(verbs);
> -
> -        }
> -
> -        if (roce_found) {
> -            if (ib_found) {
> -                warn_report("migrations may fail:"
> -                            " IPv6 over RoCE / iWARP in linux"
> -                            " is broken. But since you appear to have a"
> -                            " mixed RoCE / IB environment, be sure to only"
> -                            " migrate over the IB fabric until the kernel "
> -                            " fixes the bug.");
> -            } else {
> -                error_setg(errp, "RDMA ERROR: "
> -                           "You only have RoCE / iWARP devices in your systems"
> -                           " and your management software has specified '[::]'"
> -                           ", but IPv6 over RoCE / iWARP is not supported in Linux.");
> -                return -1;
> -            }
> -        }
> -
> -        return 0;
> -    }
> -
> -    /*
> -     * If we have a verbs context, that means that some other than '[::]' was
> -     * used by the management software for binding. In which case we can
> -     * actually warn the user about a potentially broken kernel.
> -     */
> -
> -    /* IB ports start with 1, not 0 */
> -    if (ibv_query_port(verbs, 1, &port_attr)) {
> -        error_setg(errp, "RDMA ERROR: Could not query initial IB port");
> -        return -1;
> -    }
> -
> -    if (port_attr.link_layer == IBV_LINK_LAYER_ETHERNET) {
> -        error_setg(errp, "RDMA ERROR: "
> -                   "Linux kernel's RoCE / iWARP does not support IPv6 "
> -                   "(but patches on linux-rdma in progress)");
> -        return -1;
> -    }
> -
> -#endif
> -
> -    return 0;
> -}
> -
>  /*
>   * Figure out which RDMA device corresponds to the requested IP hostname
>   * Also create the initial connection manager identifiers for opening
> @@ -955,7 +812,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
>  
>      /* Try all addresses, saving the first error in @err */
>      for (struct rdma_addrinfo *e = res; e != NULL; e = e->ai_next) {
> -        Error **local_errp = err ? NULL : &err;
>  
>          inet_ntop(e->ai_family,
>              &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, sizeof ip);
> @@ -964,13 +820,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
>          ret = rdma_resolve_addr(rdma->cm_id, NULL, e->ai_dst_addr,
>                  RDMA_RESOLVE_TIMEOUT_MS);
>          if (ret >= 0) {
> -            if (e->ai_family == AF_INET6) {
> -                ret = qemu_rdma_broken_ipv6_kernel(rdma->cm_id->verbs,
> -                                                   local_errp);
> -                if (ret < 0) {
> -                    continue;
> -                }
> -            }
>              error_free(err);

err is now unused and should be removed entirely. The comment before the
loop needs touching up as well.

>              goto route;
>          }
> @@ -2663,7 +2512,6 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
>  
>      /* Try all addresses, saving the first error in @err */
>      for (e = res; e != NULL; e = e->ai_next) {
> -        Error **local_errp = err ? NULL : &err;
>  
>          inet_ntop(e->ai_family,
>              &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, sizeof ip);
> @@ -2672,13 +2520,6 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
>          if (ret < 0) {
>              continue;
>          }
> -        if (e->ai_family == AF_INET6) {
> -            ret = qemu_rdma_broken_ipv6_kernel(listen_id->verbs,
> -                                               local_errp);
> -            if (ret < 0) {
> -                continue;
> -            }
> -        }
>          error_free(err);

Same here.

>          break;
>      }

