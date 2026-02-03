Return-Path: <linux-rdma+bounces-16446-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBelMX3MgWl1JwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16446-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 11:22:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2FBD7859
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 11:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D380A3012C41
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD6D3126DA;
	Tue,  3 Feb 2026 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGEgYKkl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5823009DA
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114090; cv=none; b=JooNDUgMylvwtlS7Qb6/UnwaE5dBiJrS3TpHvngbQB0dqJp6r5Yq73atenloEu9Tqo0NrnbRNE/jYl86fylOPcea2dgHKb5NakrL+HGaYjYCzq8VjTn47/UcB+u/UmN9JK2SabFLOczrT8BPfgT57BHD+HF+nfYgaU4IUNEv7nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114090; c=relaxed/simple;
	bh=0Hu+pjWVxKbUbi+crAMHRsxu5tpPF1ZHW4DwTDxug1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyKuT/wWQzx6k5rn1oQQGHlgraa5CtmLv/o8s2zNw7j+3opN8IV28AGa6+Q2HeJbKwJs0TYTGTI7FUCBAhSIh7CbgLftYJh8QbRVYUIR4V123Y11KL0m4w22oR7D75T378sFRogg1LZ7iQ9bdikE+rE//2mGgOwEzH4jgsDuDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGEgYKkl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770114087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TblGRIK+EVqQkPbymIqDvw5SKo5IqX4mHjR+G3bgeLc=;
	b=jGEgYKkllz3lDVqHSDJ1hr8/B7BNYNvcEdad5rzT4r3jye0CcEEGFgKNYAmOx5Wz3iY8CE
	kAXOUtR6rBKVVzaqYZDBx70XG6+enqUxLEruQ7fjBY+eKseg1xOyGlYM57rTOtBJYt/1A8
	1PN6O/XPe19lAA+UQ61JefljPzmVpgk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-kB-9cYPYMlGiKlMTHqtflw-1; Tue,
 03 Feb 2026 05:21:26 -0500
X-MC-Unique: kB-9cYPYMlGiKlMTHqtflw-1
X-Mimecast-MFC-AGG-ID: kB-9cYPYMlGiKlMTHqtflw_1770114083
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01CE7195605F;
	Tue,  3 Feb 2026 10:21:23 +0000 (UTC)
Received: from [10.43.3.114] (unknown [10.43.3.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8883619560B2;
	Tue,  3 Feb 2026 10:21:17 +0000 (UTC)
Message-ID: <67478aa2-54f5-4a3f-8063-ab6e877693e4@redhat.com>
Date: Tue, 3 Feb 2026 11:21:16 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 7/9] dpll: Add reference
 count tracking support
To: kernel test robot <lkp@intel.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-rdma@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Richard Cochran <richardcochran@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Mark Bloch <mbloch@nvidia.com>,
 linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>
References: <20260202171638.17427-8-ivecera@redhat.com>
 <202602030538.6ok1xugA-lkp@intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <202602030538.6ok1xugA-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16446-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,google.com,intel.com,kernel.org,vger.kernel.org,lists.osuosl.org,redhat.com,resnulli.us,gmail.com,microchip.com,linux.dev,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 2A2FBD7859
X-Rspamd-Action: no action



On 2/2/26 10:48 PM, kernel test robot wrote:
> Hi Ivan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Vecera/dpll-Allow-associating-dpll-pin-with-a-firmware-node/20260203-012705
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20260202171638.17427-8-ivecera%40redhat.com
> patch subject: [Intel-wired-lan] [PATCH net-next v4 7/9] dpll: Add reference count tracking support
> config: i386-randconfig-141-20260203 (https://download.01.org/0day-ci/archive/20260203/202602030538.6ok1xugA-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> smatch version: v0.5.0-8994-gd50c5a4c
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260203/202602030538.6ok1xugA-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202602030538.6ok1xugA-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     In file included from net/core/rtnetlink.c:61:
>>> include/linux/dpll.h:235:1: error: expected identifier or '('
>       235 | {
>           | ^
>     1 error generated.
> 
> 
> vim +235 include/linux/dpll.h
> 
> 877c40367bc8a7 Ivan Vecera 2026-02-02  232
> 877c40367bc8a7 Ivan Vecera 2026-02-02  233  static inline struct dpll_pin *
> bed78c2008cb37 Ivan Vecera 2026-02-02  234  fwnode_dpll_pin_find(struct fwnode_handle *fwnode, dpll_tracker *tracker);

Oh god, extra semicolon in this stub :-(

Will submit the fix after 24h grace period.

I.
> 877c40367bc8a7 Ivan Vecera 2026-02-02 @235  {
> 877c40367bc8a7 Ivan Vecera 2026-02-02  236  	return NULL;
> 877c40367bc8a7 Ivan Vecera 2026-02-02  237  }
> 5f18426928800c Jiri Pirko  2023-09-13  238  #endif
> 5f18426928800c Jiri Pirko  2023-09-13  239




