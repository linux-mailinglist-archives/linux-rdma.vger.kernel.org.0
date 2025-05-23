Return-Path: <linux-rdma+bounces-10617-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7212DAC226E
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 14:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332BE1C03E2D
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 12:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D931D2356A8;
	Fri, 23 May 2025 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mESv5129"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ACA2367A6
	for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748002426; cv=none; b=mo+754Hv2rjD7TCFSstaz2NwY/y1gdsbwPHTARHcTW6Luovxa8UISKnM6Zo6eNZneLMqzr/AP1ZfhIEaNoCYmx8bRKSf4kcTO/Sq9fYobrgEg2t2bMDMY4K4RSapAFPvXnKfJN3h5uuuykvJ5BBs8q+ng+fKgQXmIgpeVAwyANM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748002426; c=relaxed/simple;
	bh=QwnM0CAVFEMq5AF+Q3d9i2AyovIT3v6pbtbAkQmXxXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ph5cMYeJeBEy4FqRFO6p0Ee97V7DwB1n5Mv9iHEin2ytpLURRBfqiP+AFdCqdenEC1O8YHTkcpjYG7b0PRR9AHzD0tCxEnjioIQrob/bAKngGKj8600euJohAqPi4YCuF9nnvGLO7R90tfLDMvnj3efEuXOzlIqPJadK6WcpcCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=mESv5129; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-441ab63a415so95676685e9.3
        for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 05:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1748002422; x=1748607222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fcMMazqETMFBjpqAXtEjk8AFpIIhwiLrmwH6TDT81Xc=;
        b=mESv5129nr8eW9p2uje1ijmcrLD/7sXxCz8PvVSIKj6+R1AcRUPGIAZwNt5Fs9BACB
         UsTcK41KYHGwtklfZ143yDVkK15CuxOFn/A/8tuZbzgx4J1r86CyqCXgfn0GyCDaPh7X
         To1KHesvTucDqQY9WVX+W4mgf2mQ62cUWo2a+68idmLz1ZwLW/2Jlr48qlXZwVEea2JZ
         lCqpkPNBpxiTXq3kKOOJBqMEFBFZYma+ircSkzHJQgEWsP0NeXPsD65//ZIIf/BQYq/U
         8ruHg1GDqF0mSPInhP6rydgakXbFoecjKMWGVqFuy39AVXPLSWpHc/V/hsbAAWLov5Ey
         4KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748002422; x=1748607222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcMMazqETMFBjpqAXtEjk8AFpIIhwiLrmwH6TDT81Xc=;
        b=GN34pF2kd9T4/QI7J7AlTyahDhh3KPckv+hTmdQZ7V8cfFdsfq06EQC72QBqp2JFc2
         i4ybcBs4gWSj+9uI9y55xK5TIfnKkybT7gBwKc9KdZKqiHSBhdn041QuWQVc9NcQrJrC
         TXn8c/4Ia6EByAPsc63VpZO6Q4lGhwkGDh3Xd2QfofBVdzNUT+MocJOYj7ImRek2DPgz
         sPfckNYkb0jlgwKJNwKXtN0eXmexvn5lCYZHeScLnQdezKY/jpL8yBt5CGqEtSsdqVaU
         KJTcYwWzCA53TYrbyyIobjI2O/ZDL3uVMSTcL5N+jkq75LDtg3WNVB73yK+VTmr8ozJt
         zOyA==
X-Forwarded-Encrypted: i=1; AJvYcCVv4bS2EZO3OR+pwt3aFnuraEOVPwIXp2z2iuydfr9B4GSg4BaL1fDKOWnOYDoE1Y8dIYZ4C2y2Qu0+@vger.kernel.org
X-Gm-Message-State: AOJu0YzMMydCyvtNbvEdl+XV1BUw/+h5SdgS+ebYCack4jKRGoAspetd
	J6ITkV1WMwbrbfL0z/GNanMaaAN7TV8Fcp4HvTdWVyEkXFEXLDhBgWjT5Js4IKZye5k=
X-Gm-Gg: ASbGncvVt7VYDyxPzOEGPA2OLtKGkrP0kxoc/1OWnCWpBhIc66MqrTGG9beVSgg6h/e
	YsnZ2lkEix1hRxScVO51VAsGIQ5mm4NqxwH21UX3otjpRxBvy0jKmr4BLU/VR4ASKu6B186/uE8
	31sGIe6dmeiYhJjucohDwA30nTY6MB18M7HfmJ6weM70PeYY52Keyn4MzlzGgyI7yXi6BAuDp1x
	1YHzVLNnYX7pPJo3o1IZ319xEaIahhiqgK7HHibbLoNTtcC8AFDcEgwDXCq/7FHM25hrF8IweBk
	XxhyzywB8ZBfnOALQHg2Xg0kemCkzFmbZvcdWc4CqQE1H6Ccu298lVp87y8BhYk2U4IPXlbs14Z
	2f/A=
X-Google-Smtp-Source: AGHT+IFWpuJ+LGIYOg0ukSHD3MDEX+F5KEHQMJa0aTYMPEXLHnq293emw2qfMGaBfuv1xqKajS7f1w==
X-Received: by 2002:a05:600c:64cd:b0:43d:745a:5a50 with SMTP id 5b1f17b1804b1-442fd6313demr219563725e9.19.1748002421719;
        Fri, 23 May 2025 05:13:41 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a369140048sm22111829f8f.57.2025.05.23.05.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 05:13:41 -0700 (PDT)
Date: Fri, 23 May 2025 14:13:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, 
	aleksandr.loktionov@intel.com, corbet@lwn.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, 
	linux-doc@vger.kernel.org, Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH net-next v3 2/3] dpll: add reference sync get/set
Message-ID: <yklt5svyyahn56bynp7b2ba4ceonyo2ivddtr3fr2ye5ubyjjj@jpnmxnsweyf5>
References: <20250522162938.1490791-1-arkadiusz.kubalewski@intel.com>
 <20250522162938.1490791-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522162938.1490791-3-arkadiusz.kubalewski@intel.com>

Thu, May 22, 2025 at 06:29:37PM +0200, arkadiusz.kubalewski@intel.com wrote:
>Define function for reference sync pin registration and callback ops to
>set/get current feature state.
>
>Implement netlink handler to fill netlink messages with reference sync
>pin configuration of capable pins (pin-get).
>
>Implement netlink handler to call proper ops and configure reference
>sync pin state (pin-set).
>
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Reviewed-by: Milena Olech <milena.olech@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> v3:
>- fix kdoc missing ':' after argument name ref_sync_pins,
>- propagate ret in dpll_pin_ref_sync_state_set().
>---
> drivers/dpll/dpll_core.c    |  27 ++++++
> drivers/dpll/dpll_core.h    |   2 +
> drivers/dpll/dpll_netlink.c | 188 ++++++++++++++++++++++++++++++++----
> include/linux/dpll.h        |  10 ++
> 4 files changed, 209 insertions(+), 18 deletions(-)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index 20bdc52f63a5..805c7aca58c5 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -506,6 +506,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
> 	refcount_set(&pin->refcount, 1);
> 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
>+	xa_init_flags(&pin->ref_sync_pins, XA_FLAGS_ALLOC);
> 	ret = xa_alloc_cyclic(&dpll_pin_xa, &pin->id, pin, xa_limit_32b,
> 			      &dpll_pin_xa_id, GFP_KERNEL);
> 	if (ret < 0)
>@@ -514,6 +515,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
> err_xa_alloc:
> 	xa_destroy(&pin->dpll_refs);
> 	xa_destroy(&pin->parent_refs);
>+	xa_destroy(&pin->ref_sync_pins);
> 	dpll_pin_prop_free(&pin->prop);
> err_pin_prop:
> 	kfree(pin);
>@@ -595,6 +597,7 @@ void dpll_pin_put(struct dpll_pin *pin)
> 		xa_erase(&dpll_pin_xa, pin->id);
> 		xa_destroy(&pin->dpll_refs);
> 		xa_destroy(&pin->parent_refs);
>+		xa_destroy(&pin->ref_sync_pins);
> 		dpll_pin_prop_free(&pin->prop);
> 		kfree_rcu(pin, rcu);
> 	}
>@@ -783,6 +786,30 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
> }
> EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
> 
>+/**
>+ * dpll_pin_ref_sync_pair_add - create a reference sync signal pin pair
>+ * @base: pin which produces the base frequency
>+ * @sync: pin which produces the sync signal
>+ *
>+ * Once pins are paired, the user-space configuration of reference sync pair
>+ * is possible.
>+ * Context: Acquires a lock (dpll_lock)
>+ * Return:
>+ * * 0 on success
>+ * * negative - error value
>+ */
>+int dpll_pin_ref_sync_pair_add(struct dpll_pin *base, struct dpll_pin *sync)

Perhaps call it "pin" and "ref_sync_pin"?


>+{
>+	int ret;
>+
>+	mutex_lock(&dpll_lock);
>+	ret = xa_insert(&base->ref_sync_pins, sync->pin_idx, sync, GFP_KERNEL);
>+	mutex_unlock(&dpll_lock);
>+
>+	return ret;
>+}
>+EXPORT_SYMBOL_GPL(dpll_pin_ref_sync_pair_add);

How do you handle remove?


>+
> static struct dpll_device_registration *
> dpll_device_registration_first(struct dpll_device *dpll)
> {
>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>index 2b6d8ef1cdf3..93c68e78b351 100644
>--- a/drivers/dpll/dpll_core.h
>+++ b/drivers/dpll/dpll_core.h
>@@ -44,6 +44,7 @@ struct dpll_device {
>  * @module:		module of creator
>  * @dpll_refs:		hold referencees to dplls pin was registered with
>  * @parent_refs:	hold references to parent pins pin was registered with
>+ * @ref_sync_pins:	hold references to pins for Reference SYNC feature
>  * @prop:		pin properties copied from the registerer
>  * @rclk_dev_name:	holds name of device when pin can recover clock from it
>  * @refcount:		refcount
>@@ -56,6 +57,7 @@ struct dpll_pin {
> 	struct module *module;
> 	struct xarray dpll_refs;
> 	struct xarray parent_refs;
>+	struct xarray ref_sync_pins;
> 	struct dpll_pin_properties prop;
> 	refcount_t refcount;
> 	struct rcu_head rcu;
>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>index c130f87147fa..854bd46a7d27 100644
>--- a/drivers/dpll/dpll_netlink.c
>+++ b/drivers/dpll/dpll_netlink.c
>@@ -48,6 +48,24 @@ dpll_msg_add_dev_parent_handle(struct sk_buff *msg, u32 id)
> 	return 0;
> }
> 
>+static bool dpll_pin_available(struct dpll_pin *pin)
>+{
>+	struct dpll_pin_ref *par_ref;
>+	unsigned long i;
>+
>+	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
>+		return false;
>+	xa_for_each(&pin->parent_refs, i, par_ref)
>+		if (xa_get_mark(&dpll_pin_xa, par_ref->pin->id,
>+				DPLL_REGISTERED))
>+			return true;
>+	xa_for_each(&pin->dpll_refs, i, par_ref)
>+		if (xa_get_mark(&dpll_device_xa, par_ref->dpll->id,
>+				DPLL_REGISTERED))
>+			return true;
>+	return false;
>+}
>+
> /**
>  * dpll_msg_add_pin_handle - attach pin handle attribute to a given message
>  * @msg: pointer to sk_buff message to attach a pin handle
>@@ -408,6 +426,47 @@ dpll_msg_add_pin_esync(struct sk_buff *msg, struct dpll_pin *pin,
> 	return -EMSGSIZE;
> }
> 
>+static int
>+dpll_msg_add_pin_ref_sync(struct sk_buff *msg, struct dpll_pin *pin,
>+			  struct dpll_pin_ref *ref,
>+			  struct netlink_ext_ack *extack)
>+{
>+	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>+	struct dpll_device *dpll = ref->dpll;
>+	enum dpll_pin_state state;
>+	void *pin_priv, *sp_priv;
>+	struct dpll_pin *sp;

Make sure you are consistent in variables naming. You call this "sync"
whan you add it.


>+	struct nlattr *nest;
>+	unsigned long index;
>+	int ret;
>+
>+	pin_priv = dpll_pin_on_dpll_priv(dpll, pin);
>+	xa_for_each(&pin->ref_sync_pins, index, sp) {
>+		if (!dpll_pin_available(sp))
>+			continue;
>+		sp_priv = dpll_pin_on_dpll_priv(dpll, sp);
>+		if (WARN_ON(!ops->ref_sync_get))
>+			return -EOPNOTSUPP;
>+		ret = ops->ref_sync_get(pin, pin_priv, sp, sp_priv,
>+					&state, extack);
>+		if (ret)
>+			return ret;
>+		nest = nla_nest_start(msg, DPLL_A_PIN_REFERENCE_SYNC);
>+		if (!nest)
>+			return -EMSGSIZE;
>+		if (nla_put_s32(msg, DPLL_A_PIN_ID, sp->id))
>+			goto nest_cancel;
>+		if (nla_put_s32(msg, DPLL_A_PIN_STATE, state))
>+			goto nest_cancel;
>+		nla_nest_end(msg, nest);
>+	}
>+	return 0;
>+
>+nest_cancel:
>+	nla_nest_cancel(msg, nest);
>+	return -EMSGSIZE;
>+}
>+
> static bool dpll_pin_is_freq_supported(struct dpll_pin *pin, u32 freq)
> {
> 	int fs;
>@@ -550,6 +609,10 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
> 	if (ret)
> 		return ret;
> 	ret = dpll_msg_add_pin_esync(msg, pin, ref, extack);
>+	if (ret)
>+		return ret;
>+	if (!xa_empty(&pin->ref_sync_pins))
>+		ret = dpll_msg_add_pin_ref_sync(msg, pin, ref, extack);
> 	if (ret)
> 		return ret;
> 	if (xa_empty(&pin->parent_refs))
>@@ -642,24 +705,6 @@ __dpll_device_change_ntf(struct dpll_device *dpll)
> 	return dpll_device_event_send(DPLL_CMD_DEVICE_CHANGE_NTF, dpll);
> }
> 
>-static bool dpll_pin_available(struct dpll_pin *pin)
>-{
>-	struct dpll_pin_ref *par_ref;
>-	unsigned long i;
>-
>-	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
>-		return false;
>-	xa_for_each(&pin->parent_refs, i, par_ref)
>-		if (xa_get_mark(&dpll_pin_xa, par_ref->pin->id,
>-				DPLL_REGISTERED))
>-			return true;
>-	xa_for_each(&pin->dpll_refs, i, par_ref)
>-		if (xa_get_mark(&dpll_device_xa, par_ref->dpll->id,
>-				DPLL_REGISTERED))
>-			return true;
>-	return false;
>-}
>-
> /**
>  * dpll_device_change_ntf - notify that the dpll device has been changed
>  * @dpll: registered dpll pointer
>@@ -887,6 +932,108 @@ dpll_pin_esync_set(struct dpll_pin *pin, struct nlattr *a,
> 	return ret;
> }
> 
>+static int
>+dpll_pin_ref_sync_state_set(struct dpll_pin *pin, unsigned long sync_pin_idx,
>+			    const enum dpll_pin_state state,
>+			    struct netlink_ext_ack *extack)
>+
>+{
>+	struct dpll_pin_ref *ref, *failed;
>+	const struct dpll_pin_ops *ops;
>+	enum dpll_pin_state old_state;
>+	struct dpll_pin *sync_pin;

Again, please name this consistently...


>+	struct dpll_device *dpll;
>+	unsigned long i;
>+	int ret;
>+
>+	if (state != DPLL_PIN_STATE_CONNECTED &&
>+	    state != DPLL_PIN_STATE_DISCONNECTED)

Extack message? But, isn't this sanitized already by policy? Then,
please remove.


>+		return -EINVAL;
>+	sync_pin = xa_find(&pin->ref_sync_pins, &sync_pin_idx, ULONG_MAX,
>+			   XA_PRESENT);
>+	if (!sync_pin) {
>+		NL_SET_ERR_MSG(extack, "reference sync pin not found");
>+		return -EINVAL;
>+	}
>+	if (!dpll_pin_available(sync_pin)) {
>+		NL_SET_ERR_MSG(extack, "reference sync pin not available");
>+		return -EINVAL;
>+	}
>+	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
>+	ASSERT_NOT_NULL(ref);
>+	ops = dpll_pin_ops(ref);
>+	if (!ops->ref_sync_set || !ops->ref_sync_get) {
>+		NL_SET_ERR_MSG(extack, "reference sync not supported by this pin");
>+		return -EOPNOTSUPP;
>+	}
>+	dpll = ref->dpll;
>+	ret = ops->ref_sync_get(pin, dpll_pin_on_dpll_priv(dpll, pin), sync_pin,
>+				dpll_pin_on_dpll_priv(dpll, sync_pin),
>+				&old_state, extack);
>+	if (ret) {
>+		NL_SET_ERR_MSG(extack, "unable to get old reference sync state");
>+		return ret;
>+	}
>+	if (state == old_state)
>+		return 0;
>+	xa_for_each(&pin->dpll_refs, i, ref) {
>+		ops = dpll_pin_ops(ref);
>+		dpll = ref->dpll;
>+		ret = ops->ref_sync_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
>+					sync_pin,
>+					dpll_pin_on_dpll_priv(dpll, sync_pin),
>+					state, extack);
>+		if (ret) {
>+			failed = ref;
>+			NL_SET_ERR_MSG_FMT(extack, "reference sync set failed for dpll_id:%u",
>+					   dpll->id);
>+			goto rollback;
>+		}
>+	}
>+	__dpll_pin_change_ntf(pin);
>+
>+	return 0;
>+
>+rollback:
>+	xa_for_each(&pin->dpll_refs, i, ref) {
>+		if (ref == failed)
>+			break;
>+		ops = dpll_pin_ops(ref);
>+		dpll = ref->dpll;
>+		if (ops->ref_sync_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
>+				      sync_pin,
>+				      dpll_pin_on_dpll_priv(dpll, sync_pin),
>+				      old_state, extack))
>+			NL_SET_ERR_MSG(extack, "set reference sync rollback failed");
>+	}
>+	return ret;
>+}
>+
>+static int
>+dpll_pin_ref_sync_set(struct dpll_pin *pin, struct nlattr *nest,
>+		      struct netlink_ext_ack *extack)
>+{
>+	struct nlattr *tb[DPLL_A_PIN_MAX + 1];
>+	enum dpll_pin_state state;
>+	u32 sync_pin_id;
>+
>+	nla_parse_nested(tb, DPLL_A_PIN_MAX, nest,
>+			 dpll_reference_sync_nl_policy, extack);
>+	if (!tb[DPLL_A_PIN_ID]) {
>+		NL_SET_ERR_MSG(extack, "sync pin id expected");
>+		return -EINVAL;
>+	}
>+	sync_pin_id = nla_get_u32(tb[DPLL_A_PIN_ID]);
>+
>+	if (!tb[DPLL_A_PIN_STATE]) {
>+		NL_SET_ERR_MSG(extack, "sync pin state expected");
>+		return -EINVAL;
>+	}
>+	state = nla_get_u32(tb[DPLL_A_PIN_STATE]);
>+
>+	return dpll_pin_ref_sync_state_set(pin, sync_pin_id, state, extack);
>+}
>+
> static int
> dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32 parent_idx,
> 			  enum dpll_pin_state state,
>@@ -1193,6 +1340,11 @@ dpll_pin_set_from_nlattr(struct dpll_pin *pin, struct genl_info *info)
> 			if (ret)
> 				return ret;
> 			break;
>+		case DPLL_A_PIN_REFERENCE_SYNC:
>+			ret = dpll_pin_ref_sync_set(pin, a, info->extack);
>+			if (ret)
>+				return ret;
>+			break;
> 		}
> 	}
> 
>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>index 5e4f9ab1cf75..f1f1fdda67fe 100644
>--- a/include/linux/dpll.h
>+++ b/include/linux/dpll.h
>@@ -95,6 +95,14 @@ struct dpll_pin_ops {
> 			 const struct dpll_device *dpll, void *dpll_priv,
> 			 struct dpll_pin_esync *esync,
> 			 struct netlink_ext_ack *extack);
>+	int (*ref_sync_set)(const struct dpll_pin *pin, void *pin_priv,
>+			    const struct dpll_pin *ref_pin, void *ref_pin_priv,
>+			    const enum dpll_pin_state state,
>+			    struct netlink_ext_ack *extack);
>+	int (*ref_sync_get)(const struct dpll_pin *pin, void *pin_priv,
>+			    const struct dpll_pin *ref_pin, void *ref_pin_priv,

"ref_pin". This is 4th name of the same variable. Weird...


>+			    enum dpll_pin_state *state,
>+			    struct netlink_ext_ack *extack);
> };
> 
> struct dpll_pin_frequency {
>@@ -194,6 +202,8 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
> void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
> 				const struct dpll_pin_ops *ops, void *priv);
> 
>+int dpll_pin_ref_sync_pair_add(struct dpll_pin *base, struct dpll_pin *sync);
>+
> int dpll_device_change_ntf(struct dpll_device *dpll);
> 
> int dpll_pin_change_ntf(struct dpll_pin *pin);
>-- 
>2.38.1
>

