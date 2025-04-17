Return-Path: <linux-rdma+bounces-9512-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B404A9186F
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 11:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7187C19E2264
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 09:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB75022A7EE;
	Thu, 17 Apr 2025 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EeT4NAuh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EF21B4235
	for <linux-rdma@vger.kernel.org>; Thu, 17 Apr 2025 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883832; cv=none; b=nUYbiDq50Vxi5jc1INwYwoeUg0CKnqqgFVOWo12EDMoX0LTsbqN5seseooAYaTLNmadcXEzMzP5OpG7L+r4A53rx9grOd5f3IyOMW/NQn+BXWns8x34WP9dvaARM6pC7hhgVvandZ//coEEEBlUe0eb4f7WOI7DXwnc3dNz7I9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883832; c=relaxed/simple;
	bh=pBMDUiOnrDqOS+E7K+9DeISEP0MXzLDoDRlY1MG56CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgzuOjqX0W87WQzJ50sT7KK2cmZdg6dx9OemmbUR8jCoLnu5OHYoSwKqyzp+dZYD6Y9OWIGyTOWVffem0OqRWS4TR85xSTxcCLN/8fo/UfZwh9p5y5IwzqrQGN6vCPabpMNWCaZ1WKrShmGlAbxlAADwNxnx0NfrIgcW/Tfpi0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=EeT4NAuh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39ee57c0b8cso570920f8f.0
        for <linux-rdma@vger.kernel.org>; Thu, 17 Apr 2025 02:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1744883828; x=1745488628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qpa0GejaPGa/YgV9J5BKfK35uNrTR6xbnqfjaQWItJ8=;
        b=EeT4NAuhw1VqHRf9X35gE3e34+Wi5LbVyDHSuzEgQxFO0gPnZZl5Fk5jcU/XuZvZ7M
         8+lq0O3Rl6rlyeCX5Djng2Vg3Un0n0IShibfJn/Vwe9lmVjyRDm/eG85ORxLCmIUT1r2
         dLwaBjaxh4hUd7nIAta50amUnxQOS7cMi9Ru4/8txmWeKVACTzpHcYPVGflVrAtk5FZ8
         RMDub/PE81p7dGznoSJidy8qJTAC4QKmpwhnsMcpzggZCHG5+CDlBrnLMMeiHZnlByED
         vyfCP4iqoRiArLX8UPoA5UOjEaHP8eOQMm8G7me8bdU+TMQPxVwFS6sKdHIjrNWpiZ6Q
         c5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744883828; x=1745488628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qpa0GejaPGa/YgV9J5BKfK35uNrTR6xbnqfjaQWItJ8=;
        b=Zk0w5I84+NDjQ2Ug6tpcyNbCwe/fhwQ6fpW5FRpCzqiWS9u9X64HQKUv1tNT6Jmpsv
         RAiIEkRnEMzJyKHVJJ60RshZERcKGzLtTaIKFfoPt8WcQeP+NbdZZAWj8eF2m02b5/z7
         ZchdoLLPNFK0u5HTqoTcdFVqtTHtz7Z1OKb/tumTWTTF6OvD8nYE/ef9XKYezxQyisRc
         jnn8IPUpwcHJ2BppAX7omXGDT6uC+CdTHO5Lu0b8Gza6decCw2v8kucJMR6NyNxnehDx
         CrmY/5hN6sURLpjPUQB3gWWav9dGC3jhBXBff+OJZjXkyUlkSyLqC27Lm/M55nHPxvzn
         TC6g==
X-Forwarded-Encrypted: i=1; AJvYcCXmLyx2iO3kvnkj197LibjhImjt4tsX3RPiKpCgldn4hmB10lm8leIIC2j1CGtpbuNcUs6eUWfb86ls@vger.kernel.org
X-Gm-Message-State: AOJu0YxYYg5wUOehdbLHOJtrWMuwNj8qbQKEF4SZ49m/pFwsIDmSgjDc
	tdr70a/BCP6Ajb7Rzf7xgDm7YDm8PTLizqo9THP0gGyZRcW7Q5maaBKdl2eIuU8=
X-Gm-Gg: ASbGnct1C7/mSiXuIq1cxPkiGMGEufemIDA8+y8PQUr9xgIFcjxqMZLSh7X8KnUlN51
	4nlrGyblNx5Ys1uZGGPgo9Z6xAOOD0Y6sS5JMCRVUpPPCWaJBHVrZzmiFiHwr/nr0LTo2XP5mbx
	Cm4AVyOh3l96qAou3RmUZ1syiPrxDqn7HYd9eNyejQzMFmHbRino3gjhEoT0b0agfsyXKj5k5EK
	O/PcxckZrW2OlZN3PtHVUgeZ6Zl7A5QBhYZxmOkV8SiStNARuh5Tb8m6dXmA5Nt/r2T3PwdnYnJ
	AOHrT8sBuH93ahB/8UVfthjIQkC+RdJbn17FtY69pTegl1kjgcEjdG1Iho4=
X-Google-Smtp-Source: AGHT+IHiGt3l/NvC3zreHayL8q6Ll/TbkBU6XHlIyltvZMzxuQ1tIBzUxWef/1T1KtUtmPP2UFlABQ==
X-Received: by 2002:a05:6000:2404:b0:391:3406:b4e2 with SMTP id ffacd0b85a97d-39ee5baf441mr4170193f8f.49.1744883827740;
        Thu, 17 Apr 2025 02:57:07 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96c684sm19781607f8f.33.2025.04.17.02.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 02:57:07 -0700 (PDT)
Date: Thu, 17 Apr 2025 11:56:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "donald.hunter@gmail.com" <donald.hunter@gmail.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"Dumazet, Eric" <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "saeedm@nvidia.com" <saeedm@nvidia.com>, 
	"leon@kernel.org" <leon@kernel.org>, "tariqt@nvidia.com" <tariqt@nvidia.com>, 
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>, "richardcochran@gmail.com" <richardcochran@gmail.com>, 
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Olech, Milena" <milena.olech@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/4] dpll: use struct dpll_device_info for
 dpll registration
Message-ID: <slvow56opklcc2hwz4vzq4t7olazddmvn4lxhoveb43f6mz4p2@6vq3iz7kiuce>
References: <20250415181543.1072342-1-arkadiusz.kubalewski@intel.com>
 <20250415181543.1072342-2-arkadiusz.kubalewski@intel.com>
 <zurfm4rox22l3dnffbfloax5mu6csiycqqfoyh5nrcsd4ada6h@wmeh5ks4gli6>
 <SJ2PR11MB84526DB089614BD2972F6BA49BBC2@SJ2PR11MB8452.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR11MB84526DB089614BD2972F6BA49BBC2@SJ2PR11MB8452.namprd11.prod.outlook.com>

Thu, Apr 17, 2025 at 11:33:13AM +0200, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Wednesday, April 16, 2025 2:13 PM
>>
>>Tue, Apr 15, 2025 at 08:15:40PM +0200, arkadiusz.kubalewski@intel.com
>>wrote:
>>>Instead of passing list of properties as arguments to
>>>dpll_device_register(..) use a dedicated struct.
>>>
>>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>---
>>>v2:
>>>- new commit
>>>---
>>> drivers/dpll/dpll_core.c                      | 34 ++++++++++++-------
>>> drivers/dpll/dpll_core.h                      |  2 +-
>>> drivers/dpll/dpll_netlink.c                   |  7 ++--
>>> drivers/net/ethernet/intel/ice/ice_dpll.c     | 16 +++++----
>>> drivers/net/ethernet/intel/ice/ice_dpll.h     |  1 +
>>> .../net/ethernet/mellanox/mlx5/core/dpll.c    | 10 +++---
>>> drivers/ptp/ptp_ocp.c                         |  7 ++--
>>> include/linux/dpll.h                          | 11 ++++--
>>> 8 files changed, 57 insertions(+), 31 deletions(-)
>>>
>>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>>index 20bdc52f63a5..af9cda45a89c 100644
>>>--- a/drivers/dpll/dpll_core.c
>>>+++ b/drivers/dpll/dpll_core.c
>>>@@ -34,7 +34,7 @@ static u32 dpll_pin_xa_id;
>>>
>>> struct dpll_device_registration {
>>> 	struct list_head list;
>>>-	const struct dpll_device_ops *ops;
>>>+	const struct dpll_device_info *info;
>>> 	void *priv;
>>> };
>>>
>>>@@ -327,12 +327,12 @@ EXPORT_SYMBOL_GPL(dpll_device_put);
>>>
>>> static struct dpll_device_registration *
>>> dpll_device_registration_find(struct dpll_device *dpll,
>>>-			      const struct dpll_device_ops *ops, void *priv)
>>>+			      const struct dpll_device_info *info, void *priv)
>>> {
>>> 	struct dpll_device_registration *reg;
>>>
>>> 	list_for_each_entry(reg, &dpll->registration_list, list) {
>>>-		if (reg->ops == ops && reg->priv == priv)
>>>+		if (reg->info == info && reg->priv == priv)
>>> 			return reg;
>>> 	}
>>> 	return NULL;
>>>@@ -341,8 +341,7 @@ dpll_device_registration_find(struct dpll_device
>>>*dpll,
>>> /**
>>>  * dpll_device_register - register the dpll device in the subsystem
>>>  * @dpll: pointer to a dpll
>>>- * @type: type of a dpll
>>>- * @ops: ops for a dpll device
>>>+ * @info: dpll device information and operations from registerer
>>>  * @priv: pointer to private information of owner
>>>  *
>>>  * Make dpll device available for user space.
>>>@@ -352,11 +351,13 @@ dpll_device_registration_find(struct dpll_device
>>>*dpll,
>>>  * * 0 on success
>>>  * * negative - error value
>>>  */
>>>-int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
>>>-			 const struct dpll_device_ops *ops, void *priv)
>>>+int dpll_device_register(struct dpll_device *dpll,
>>>+			 const struct dpll_device_info *info, void *priv)
>>
>>I don't like this. If you need some capabilities value, put it into ops
>>struct.
>>
>
>Hmm, this would seems strange, the _ops indicates operations, would
>have to rename the struct..

I don't think so. Happens all the time in kernel for ops to contain
other things.


>
>In theory I could decide on capabilities per ops provided from driver..
>i.e. If phase_input_monitor_feature_set()/phase_input_feature_get() are
>present then capability phase_input_monitor is provided..
>Makes sense?

Yes, that is more or less what I suggested in reply to the other patch
in this set.


>
>>
>>> {
>>>+	const struct dpll_device_ops *ops = info->ops;
>>> 	struct dpll_device_registration *reg;
>>> 	bool first_registration = false;
>>>+	enum dpll_type type = info->type;
>>>
>>> 	if (WARN_ON(!ops))
>>> 		return -EINVAL;
>>>@@ -368,7 +369,7 @@ int dpll_device_register(struct dpll_device *dpll,
>>>enum dpll_type type,
>>> 		return -EINVAL;
>>>
>>> 	mutex_lock(&dpll_lock);
>>>-	reg = dpll_device_registration_find(dpll, ops, priv);
>>>+	reg = dpll_device_registration_find(dpll, info, priv);
>>> 	if (reg) {
>>> 		mutex_unlock(&dpll_lock);
>>> 		return -EEXIST;
>>>@@ -379,9 +380,8 @@ int dpll_device_register(struct dpll_device *dpll,
>>>enum dpll_type type,
>>> 		mutex_unlock(&dpll_lock);
>>> 		return -ENOMEM;
>>> 	}
>>>-	reg->ops = ops;
>>>+	reg->info = info;
>>> 	reg->priv = priv;
>>>-	dpll->type = type;
>>> 	first_registration = list_empty(&dpll->registration_list);
>>> 	list_add_tail(&reg->list, &dpll->registration_list);
>>> 	if (!first_registration) {
>>>@@ -408,14 +408,14 @@ EXPORT_SYMBOL_GPL(dpll_device_register);
>>>  * Context: Acquires a lock (dpll_lock)
>>>  */
>>> void dpll_device_unregister(struct dpll_device *dpll,
>>>-			    const struct dpll_device_ops *ops, void *priv)
>>>+			    const struct dpll_device_info *info, void *priv)
>>> {
>>> 	struct dpll_device_registration *reg;
>>>
>>> 	mutex_lock(&dpll_lock);
>>> 	ASSERT_DPLL_REGISTERED(dpll);
>>> 	dpll_device_delete_ntf(dpll);
>>>-	reg = dpll_device_registration_find(dpll, ops, priv);
>>>+	reg = dpll_device_registration_find(dpll, info, priv);
>>> 	if (WARN_ON(!reg)) {
>>> 		mutex_unlock(&dpll_lock);
>>> 		return;
>>>@@ -807,7 +807,15 @@ const struct dpll_device_ops *dpll_device_ops(struct
>>>dpll_device *dpll)
>>> 	struct dpll_device_registration *reg;
>>>
>>> 	reg = dpll_device_registration_first(dpll);
>>>-	return reg->ops;
>>>+	return reg->info->ops;
>>>+}
>>>+
>>>+const struct dpll_device_info *dpll_device_info(struct dpll_device *dpll)
>>
>>Makes me wonder what you would need this for. I guess "nothing"?
>>
>
>Now using it to get info struct from dpll.. if struct is removed then yeah.
>
>Thank you!
>Arkadiusz
>
>>
>>>+{
>>>+	struct dpll_device_registration *reg;
>>>+
>>>+	reg = dpll_device_registration_first(dpll);
>>>+	return reg->info;
>>> }
>>>
>>> static struct dpll_pin_registration *
>>>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>>>index 2b6d8ef1cdf3..baeb10d7dc1e 100644
>>>--- a/drivers/dpll/dpll_core.h
>>>+++ b/drivers/dpll/dpll_core.h
>>>@@ -30,7 +30,6 @@ struct dpll_device {
>>> 	u32 device_idx;
>>> 	u64 clock_id;
>>> 	struct module *module;
>>>-	enum dpll_type type;
>>> 	struct xarray pin_refs;
>>> 	refcount_t refcount;
>>> 	struct list_head registration_list;
>>>@@ -84,6 +83,7 @@ void *dpll_pin_on_pin_priv(struct dpll_pin *parent,
>>>struct dpll_pin *pin);
>>> const struct dpll_device_ops *dpll_device_ops(struct dpll_device *dpll);
>>> struct dpll_device *dpll_device_get_by_id(int id);
>>> const struct dpll_pin_ops *dpll_pin_ops(struct dpll_pin_ref *ref);
>>>+const struct dpll_device_info *dpll_device_info(struct dpll_device
>>>*dpll);
>>> struct dpll_pin_ref *dpll_xa_ref_dpll_first(struct xarray *xa_refs);
>>> extern struct xarray dpll_device_xa;
>>> extern struct xarray dpll_pin_xa;
>>>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>>index c130f87147fa..2de9ec08d551 100644
>>>--- a/drivers/dpll/dpll_netlink.c
>>>+++ b/drivers/dpll/dpll_netlink.c
>>>@@ -564,6 +564,7 @@ static int
>>> dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
>>> 		    struct netlink_ext_ack *extack)
>>> {
>>>+	const struct dpll_device_info *info = dpll_device_info(dpll);
>>> 	int ret;
>>>
>>> 	ret = dpll_msg_add_dev_handle(msg, dpll);
>>>@@ -589,7 +590,7 @@ dpll_device_get_one(struct dpll_device *dpll, struct
>>>sk_buff *msg,
>>> 	ret = dpll_msg_add_mode_supported(msg, dpll, extack);
>>> 	if (ret)
>>> 		return ret;
>>>-	if (nla_put_u32(msg, DPLL_A_TYPE, dpll->type))
>>>+	if (nla_put_u32(msg, DPLL_A_TYPE, info->type))
>>> 		return -EMSGSIZE;
>>>
>>> 	return 0;
>>>@@ -1415,11 +1416,13 @@ dpll_device_find(u64 clock_id, struct nlattr
>>>*mod_name_attr,
>>> 	unsigned long i;
>>>
>>> 	xa_for_each_marked(&dpll_device_xa, i, dpll, DPLL_REGISTERED) {
>>>+		const struct dpll_device_info *info = dpll_device_info(dpll);
>>>+
>>> 		cid_match = clock_id ? dpll->clock_id == clock_id : true;
>>> 		mod_match = mod_name_attr ? (module_name(dpll->module) ?
>>> 			!nla_strcmp(mod_name_attr,
>>> 				    module_name(dpll->module)) : false) : true;
>>>-		type_match = type ? dpll->type == type : true;
>>>+		type_match = type ? info->type == type : true;
>>> 		if (cid_match && mod_match && type_match) {
>>> 			if (dpll_match) {
>>> 				NL_SET_ERR_MSG(extack, "multiple matches");
>>>diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
>>>b/drivers/net/ethernet/intel/ice/ice_dpll.c
>>>index bce3ad6ca2a6..0f7440a889ac 100644
>>>--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
>>>+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
>>>@@ -1977,7 +1977,7 @@ static void
>>> ice_dpll_deinit_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu)
>>> {
>>> 	if (cgu)
>>>-		dpll_device_unregister(d->dpll, &ice_dpll_ops, d);
>>>+		dpll_device_unregister(d->dpll, &d->info, d);
>>> 	dpll_device_put(d->dpll);
>>> }
>>>
>>>@@ -1996,8 +1996,7 @@ ice_dpll_deinit_dpll(struct ice_pf *pf, struct
>>>ice_dpll *d, bool cgu)
>>>  * * negative - initialization failure reason
>>>  */
>>> static int
>>>-ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
>>>-		   enum dpll_type type)
>>>+ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu)
>>> {
>>> 	u64 clock_id = pf->dplls.clock_id;
>>> 	int ret;
>>>@@ -2012,7 +2011,7 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct
>>>ice_dpll *d, bool cgu,
>>> 	d->pf = pf;
>>> 	if (cgu) {
>>> 		ice_dpll_update_state(pf, d, true);
>>>-		ret = dpll_device_register(d->dpll, type, &ice_dpll_ops, d);
>>>+		ret = dpll_device_register(d->dpll, &d->info, d);
>>> 		if (ret) {
>>> 			dpll_device_put(d->dpll);
>>> 			return ret;
>>>@@ -2363,7 +2362,12 @@ static int ice_dpll_init_info(struct ice_pf *pf,
>>>bool cgu)
>>> 	if (ret)
>>> 		return ret;
>>> 	de->mode = DPLL_MODE_AUTOMATIC;
>>>+	de->info.type = DPLL_TYPE_EEC;
>>>+	de->info.ops = &ice_dpll_ops;
>>>+
>>> 	dp->mode = DPLL_MODE_AUTOMATIC;
>>>+	dp->info.type = DPLL_TYPE_PPS;
>>>+	dp->info.ops = &ice_dpll_ops;
>>>
>>> 	dev_dbg(ice_pf_to_dev(pf),
>>> 		"%s - success, inputs:%u, outputs:%u rclk-parents:%u\n",
>>>@@ -2426,10 +2430,10 @@ void ice_dpll_init(struct ice_pf *pf)
>>> 	err = ice_dpll_init_info(pf, cgu);
>>> 	if (err)
>>> 		goto err_exit;
>>>-	err = ice_dpll_init_dpll(pf, &pf->dplls.eec, cgu, DPLL_TYPE_EEC);
>>>+	err = ice_dpll_init_dpll(pf, &pf->dplls.eec, cgu);
>>> 	if (err)
>>> 		goto deinit_info;
>>>-	err = ice_dpll_init_dpll(pf, &pf->dplls.pps, cgu, DPLL_TYPE_PPS);
>>>+	err = ice_dpll_init_dpll(pf, &pf->dplls.pps, cgu);
>>> 	if (err)
>>> 		goto deinit_eec;
>>> 	err = ice_dpll_init_pins(pf, cgu);
>>>diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h
>>>b/drivers/net/ethernet/intel/ice/ice_dpll.h
>>>index c320f1bf7d6d..9db7463e293a 100644
>>>--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
>>>+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
>>>@@ -66,6 +66,7 @@ struct ice_dpll {
>>> 	enum dpll_mode mode;
>>> 	struct dpll_pin *active_input;
>>> 	struct dpll_pin *prev_input;
>>>+	struct dpll_device_info info;
>>> };
>>>
>>> /** ice_dplls - store info required for CCU (clock controlling unit)
>>>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>>>b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>>>index 1e5522a19483..f722b1de0754 100644
>>>--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>>>+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>>>@@ -20,6 +20,7 @@ struct mlx5_dpll {
>>> 	} last;
>>> 	struct notifier_block mdev_nb;
>>> 	struct net_device *tracking_netdev;
>>>+	struct dpll_device_info info;
>>> };
>>>
>>> static int mlx5_dpll_clock_id_get(struct mlx5_core_dev *mdev, u64
>>>*clock_id)
>>>@@ -444,8 +445,9 @@ static int mlx5_dpll_probe(struct auxiliary_device
>>>*adev,
>>> 		goto err_free_mdpll;
>>> 	}
>>>
>>>-	err = dpll_device_register(mdpll->dpll, DPLL_TYPE_EEC,
>>>-				   &mlx5_dpll_device_ops, mdpll);
>>>+	mdpll->info.type = DPLL_TYPE_EEC;
>>>+	mdpll->info.ops = &mlx5_dpll_device_ops;
>>>+	err = dpll_device_register(mdpll->dpll, &mdpll->info, mdpll);
>>> 	if (err)
>>> 		goto err_put_dpll_device;
>>>
>>>@@ -481,7 +483,7 @@ static int mlx5_dpll_probe(struct auxiliary_device
>>>*adev,
>>> err_put_dpll_pin:
>>> 	dpll_pin_put(mdpll->dpll_pin);
>>> err_unregister_dpll_device:
>>>-	dpll_device_unregister(mdpll->dpll, &mlx5_dpll_device_ops, mdpll);
>>>+	dpll_device_unregister(mdpll->dpll, &mdpll->info, mdpll);
>>> err_put_dpll_device:
>>> 	dpll_device_put(mdpll->dpll);
>>> err_free_mdpll:
>>>@@ -500,7 +502,7 @@ static void mlx5_dpll_remove(struct auxiliary_device
>>>*adev)
>>> 	dpll_pin_unregister(mdpll->dpll, mdpll->dpll_pin,
>>> 			    &mlx5_dpll_pins_ops, mdpll);
>>> 	dpll_pin_put(mdpll->dpll_pin);
>>>-	dpll_device_unregister(mdpll->dpll, &mlx5_dpll_device_ops, mdpll);
>>>+	dpll_device_unregister(mdpll->dpll, &mdpll->info, mdpll);
>>> 	dpll_device_put(mdpll->dpll);
>>> 	kfree(mdpll);
>>>
>>>diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
>>>index 7945c6be1f7c..b3c5d294acb4 100644
>>>--- a/drivers/ptp/ptp_ocp.c
>>>+++ b/drivers/ptp/ptp_ocp.c
>>>@@ -382,6 +382,7 @@ struct ptp_ocp {
>>> 	struct ptp_ocp_sma_connector sma[OCP_SMA_NUM];
>>> 	const struct ocp_sma_op *sma_op;
>>> 	struct dpll_device *dpll;
>>>+	struct dpll_device_info	dpll_info;
>>> };
>>>
>>> #define OCP_REQ_TIMESTAMP	BIT(0)
>>>@@ -4745,7 +4746,9 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct
>>>pci_device_id *id)
>>> 		goto out;
>>> 	}
>>>
>>>-	err = dpll_device_register(bp->dpll, DPLL_TYPE_PPS, &dpll_ops, bp);
>>>+	bp->dpll_info.type = DPLL_TYPE_PPS;
>>>+	bp->dpll_info.ops = &dpll_ops;
>>>+	err = dpll_device_register(bp->dpll, &bp->dpll_info, bp);
>>> 	if (err)
>>> 		goto out;
>>>
>>>@@ -4796,7 +4799,7 @@ ptp_ocp_remove(struct pci_dev *pdev)
>>> 			dpll_pin_put(bp->sma[i].dpll_pin);
>>> 		}
>>> 	}
>>>-	dpll_device_unregister(bp->dpll, &dpll_ops, bp);
>>>+	dpll_device_unregister(bp->dpll, &bp->dpll_info, bp);
>>> 	dpll_device_put(bp->dpll);
>>> 	devlink_unregister(devlink);
>>> 	ptp_ocp_detach(bp);
>>>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>>>index 5e4f9ab1cf75..0489464af958 100644
>>>--- a/include/linux/dpll.h
>>>+++ b/include/linux/dpll.h
>>>@@ -97,6 +97,11 @@ struct dpll_pin_ops {
>>> 			 struct netlink_ext_ack *extack);
>>> };
>>>
>>>+struct dpll_device_info {
>>>+	enum dpll_type type;
>>>+	const struct dpll_device_ops *ops;
>>>+};
>>>+
>>> struct dpll_pin_frequency {
>>> 	u64 min;
>>> 	u64 max;
>>>@@ -170,11 +175,11 @@ dpll_device_get(u64 clock_id, u32 dev_driver_id,
>>>struct module *module);
>>>
>>> void dpll_device_put(struct dpll_device *dpll);
>>>
>>>-int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
>>>-			 const struct dpll_device_ops *ops, void *priv);
>>>+int dpll_device_register(struct dpll_device *dpll,
>>>+			 const struct dpll_device_info *info, void *priv);
>>>
>>> void dpll_device_unregister(struct dpll_device *dpll,
>>>-			    const struct dpll_device_ops *ops, void *priv);
>>>+			    const struct dpll_device_info *info, void *priv);
>>>
>>> struct dpll_pin *
>>> dpll_pin_get(u64 clock_id, u32 dev_driver_id, struct module *module,
>>>--
>>>2.38.1
>>>

