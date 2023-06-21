Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF707383C1
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jun 2023 14:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjFUM2r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jun 2023 08:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjFUM2p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jun 2023 08:28:45 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBCA19A4
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jun 2023 05:28:42 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f9b1a117caso29866485e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jun 2023 05:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687350520; x=1689942520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JY6qu40VU0iOU+uQjSN/rpx66RGcpmW4WoflmnS71Xs=;
        b=QJYEvSQGMsdga3Sw+LEwbmfVCv51FFTfe+zTbbvvLwPUJ0LE4ezg0a9FAPbbtvS79j
         ldxilCxXfk/qb7MqAy+ESNd212YZxzqu3oycOTPossmGxj/+Lb2eOqOOf9lcPEMGXAEN
         PiEYqFDWetWK8ZfRYfrmZm/9P89sNnGCcrKh+GQE86nDsP6EGdk29TuwFXKUxE/dT5c4
         kUzlr7iP+NMAGevxrG3+JX0+3jlshbVy1oEq1ZHpEdLRStJDOrBcIv/hLMaGbpLbE0oh
         XBXCRXJpf4jxbClgVqR/q8D15/odn7mAE5hds9N3YLjCa841c6Sp0r20lDZIHsSQdQ6S
         NwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687350520; x=1689942520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JY6qu40VU0iOU+uQjSN/rpx66RGcpmW4WoflmnS71Xs=;
        b=b/eeo8cXQDDpZ8ONZX9mTBi/Iny4JK3pe5sc1wpPg1XS8GM9yF5pVLPofErDnp0won
         P3xSvQALFcdOqo1DGClEFRmnrSG/ppRCblF9c8hpdFzJqNw5A0dU68o4aqPxo7ocuffX
         Hkjo9PsB9MfWKqUGJwQOF3YUqiQ78toJkQZ7AvALMlKTE4KkYvd74kcyIsfCcx+JH7l3
         BDCPHEUghFzVBpkTmv+seZLot9LwdcDyyWx31xRVi4asTJK7YF3zjVLA/jn/aOWzKFNP
         GJ5oF3pbtZe0M2iuTBKn7bL9gzEZDIE06mPVkZBovfFEU3lcQ9pHvBCU6fgkAQcN/9yz
         JKPw==
X-Gm-Message-State: AC+VfDxtFex5HMmQu4R/EbDAT0uNilsnURjcVBJDyN3Udv649GgRaEOH
        0Tj2x0Wsl4g01IeeXN968VXAfA==
X-Google-Smtp-Source: ACHHUZ60rXBng2He7vOU89dbQRdYFpRJqDtQ+N0XHlr2RIF8GRtfIJ4xQCwrAe/ejPJeeSMNSO3pmQ==
X-Received: by 2002:a05:600c:2315:b0:3f9:b02:9103 with SMTP id 21-20020a05600c231500b003f90b029103mr6786163wmo.29.1687350520103;
        Wed, 21 Jun 2023 05:28:40 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c240900b003f93c450657sm4835029wmp.38.2023.06.21.05.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 05:28:39 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:28:38 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc:     "kuba@kernel.org" <kuba@kernel.org>,
        "vadfed@meta.com" <vadfed@meta.com>,
        "jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "vadfed@fb.com" <vadfed@fb.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "M, Saeed" <saeedm@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "sj@kernel.org" <sj@kernel.org>,
        "javierm@redhat.com" <javierm@redhat.com>,
        "ricardo.canuelo@collabora.com" <ricardo.canuelo@collabora.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "Michalik, Michal" <michal.michalik@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jacek.lawrynowicz@linux.intel.com" 
        <jacek.lawrynowicz@linux.intel.com>,
        "airlied@redhat.com" <airlied@redhat.com>,
        "ogabbay@kernel.org" <ogabbay@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "nipun.gupta@amd.com" <nipun.gupta@amd.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux@zary.sk" <linux@zary.sk>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "Olech, Milena" <milena.olech@intel.com>,
        "kuniyu@amazon.com" <kuniyu@amazon.com>,
        "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "andy.ren@getcruise.com" <andy.ren@getcruise.com>,
        "razor@blackwall.org" <razor@blackwall.org>,
        "idosch@nvidia.com" <idosch@nvidia.com>,
        "lucien.xin@gmail.com" <lucien.xin@gmail.com>,
        "nicolas.dichtel@6wind.com" <nicolas.dichtel@6wind.com>,
        "phil@nwl.cc" <phil@nwl.cc>,
        "claudiajkang@gmail.com" <claudiajkang@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>,
        mschmidt <mschmidt@redhat.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: Re: [RFC PATCH v8 08/10] ice: implement dpll interface to control cgu
Message-ID: <ZJLs9np6CgKOtrWN@nanopsycho>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
 <20230609121853.3607724-9-arkadiusz.kubalewski@intel.com>
 <ZIRI+/YDZMQJVs3i@nanopsycho>
 <DM6PR11MB4657C07B0DA46408BDD957CD9B5FA@DM6PR11MB4657.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4657C07B0DA46408BDD957CD9B5FA@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Mon, Jun 19, 2023 at 08:08:11PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Saturday, June 10, 2023 11:57 AM
>>
>>Fri, Jun 09, 2023 at 02:18:51PM CEST, arkadiusz.kubalewski@intel.com wrote:

[...]


>>>+/**
>>>+ * ice_dpll_cb_lock - lock dplls mutex in callback context
>>>+ * @pf: private board structure
>>>+ *
>>>+ * Lock the mutex from the callback operations invoked by dpll subsystem.
>>>+ * Prevent dead lock caused by `rmmod ice` when dpll callbacks are under
>>>stress
>>
>>"dead lock", really? Which one? Didn't you want to write "livelock"?
>>
>
>As explained, rmmod takes and destroys lock, it can happen that
>netlink request/ops hangs on trying to lock when rmmod started deinit.

Yeah, don't take the lock in rmmod, see below.


>
>>If this is livelock prevention, is this something you really see or
>>just an assumption? Seems to me unlikely.
>>
>>Plus, see my note in ice_dpll_init(). If you remove taking the lock from
>>ice_dpll_init() and ice_dpll_deinit(), do you still need this? I don't
>>think so.
>>
>
>I won't remove it from there, as the lock shall serialize the access to ice dpll
>data, so it must be held on init until everything is ready for netlink access,

Before you register the dpll device/pin, no netlink cmd can happen. So
do whatever you want in the init, no lock needed, register at the and
when you are ready. Same on deinit. After you unregister, no call can
happen, no need to lock anything in deinit.

Either I'm missing something really odd, or your locking scheme is very
wrong.

If this locking here is needed, could you please present an example of a
race it solves here?



>or when deinit takes place, until everything is released.
>
>>
>>>+ * tests.
>>>+ *
>>>+ * Return:
>>>+ * 0 - if lock acquired
>>>+ * negative - lock not acquired or dpll was deinitialized
>>>+ */
>>>+static int ice_dpll_cb_lock(struct ice_pf *pf)
>>>+{
>>>+	int i;
>>>+
>>>+	for (i = 0; i < ICE_DPLL_LOCK_TRIES; i++) {
>>>+		if (mutex_trylock(&pf->dplls.lock))
>>>+			return 0;
>>>+		usleep_range(100, 150);
>>>+		if (!test_bit(ICE_FLAG_DPLL, pf->flags))
>>
>>How exactly could this happen? I don't think it can. Drop it.
>>
>
>Asynchronously called deinit, and kworker tries to update at the same time.

Could you provide an example please?
Because I see 2 possible paths:
1) dpll op call
2) periodic work

But when ICE_FLAG_DPLL is cleared in ice_dpll_deinit(), no dpll op call
can happen anymore and no periodic work is scheduled.

Is this another "just in case" situation? If yes, please remove.
If no, please provide an example of a race this solves.


>
>>
>>>+			return -EFAULT;
>>>+	}
>>>+
>>>+	return -EBUSY;
>>>+}

[...]


>>>+static void ice_dpll_periodic_work(struct kthread_work *work)
>>>+{
>>>+	struct ice_dplls *d = container_of(work, struct ice_dplls,
>>>work.work);
>>>+	struct ice_pf *pf = container_of(d, struct ice_pf, dplls);
>>>+	struct ice_dpll *de = &pf->dplls.eec;
>>>+	struct ice_dpll *dp = &pf->dplls.pps;
>>>+	int ret = 0;
>>>+
>>>+	if (!test_bit(ICE_FLAG_DPLL, pf->flags))
>>
>>How exactly could this happen? I don't think it can. Drop it.
>>
>
>I will change a bit here, ice_dpll_cb_lock returns an error
>if that flag was already down, so will use it instead.

Yeah, I believe that this simply cannot happen as when the bit is
cleared, no work is scheduled anymore. See above.


>
>>
>>>+		return;
>>>+	ret = ice_dpll_cb_lock(pf);
>>>+	if (ret) {
>>>+		d->lock_err_num++;
>>

[...]


>
>>>+		mutex_lock(&pf->dplls.lock);
>>
>>Related to my question in ice_dpll_init(), why do you need to lock the
>>mutex
>>here?
>
>Because before deinit takes place on driver unload the user can still ask
>for the info from the dpll subsystem or kworker can try to alter the status.

When you unregister dpll and stop the kworker, you can't see anything
like that. No need to take this lock.


>
>>
>>
>>>+		ice_dpll_deinit_pins(pf, cgu);
>>>+		ice_dpll_deinit_info(pf);
>>>+		ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu);
>>>+		ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu);
>>
>>Please reorder to match error path in ice_dpll_init()
>>
>
>Fixed.
>
>>>+		if (cgu)
>>
>>In ice_dpll_init() you call this "cgu_present". Please be consistent in
>>naming.
>>
>
>Fixed.
>
>>
>>>+			ice_dpll_deinit_worker(pf);
>>>+		clear_bit(ICE_FLAG_DPLL, pf->flags);
>>>+		mutex_unlock(&pf->dplls.lock);
>>>+		mutex_destroy(&pf->dplls.lock);
>>>+	}
>>>+}
>>>+
>>>+/**
>>>+ * ice_dpll_init_info_direct_pins - initializes direct pins info
>>>+ * @pf: board private structure
>>>+ * @pin_type: type of pins being initialized
>>>+ *
>>>+ * Init information for directly connected pins, cache them in pf's pins
>>>+ * structures.
>>>+ *
>>>+ * Context: Function initializes and holds pf->dplls.lock mutex.
>>>+ * Return:
>>>+ * * 0 - success
>>>+ * * negative - init failure reason
>>>+ */
>>>+static int
>>>+ice_dpll_init_info_direct_pins(struct ice_pf *pf,
>>>+			       enum ice_dpll_pin_type pin_type)
>>>+{
>>>+	struct ice_dpll *de = &pf->dplls.eec, *dp = &pf->dplls.pps;
>>>+	int num_pins, i, ret = -EINVAL;
>>>+	struct ice_hw *hw = &pf->hw;
>>>+	struct ice_dpll_pin *pins;
>>>+	u8 freq_supp_num;
>>>+	bool input;
>>>+
>>>+	switch (pin_type) {
>>>+	case ICE_DPLL_PIN_TYPE_INPUT:
>>>+		pins = pf->dplls.inputs;
>>>+		num_pins = pf->dplls.num_inputs;
>>>+		input = true;
>>>+		break;
>>>+	case ICE_DPLL_PIN_TYPE_OUTPUT:
>>>+		pins = pf->dplls.outputs;
>>>+		num_pins = pf->dplls.num_outputs;
>>>+		input = false;
>>>+		break;
>>>+	default:
>>>+		return ret;
>>>+	}
>>>+
>>>+	for (i = 0; i < num_pins; i++) {
>>>+		pins[i].idx = i;
>>>+		pins[i].prop.board_label = ice_cgu_get_pin_name(hw, i, input);
>>>+		pins[i].prop.type = ice_cgu_get_pin_type(hw, i, input);
>>>+		if (input) {
>>>+			ret = ice_aq_get_cgu_ref_prio(hw, de->dpll_idx, i,
>>>+						      &de->input_prio[i]);
>>>+			if (ret)
>>>+				return ret;
>>>+			ret = ice_aq_get_cgu_ref_prio(hw, dp->dpll_idx, i,
>>>+						      &dp->input_prio[i]);
>>>+			if (ret)
>>>+				return ret;
>>>+			pins[i].prop.capabilities |=
>>>+				DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE;
>>>+		}
>>>+		pins[i].prop.capabilities |= DPLL_PIN_CAPS_STATE_CAN_CHANGE;
>>>+		ret = ice_dpll_pin_state_update(pf, &pins[i], pin_type);
>>>+		if (ret)
>>>+			return ret;
>>>+		pins[i].prop.freq_supported =
>>>+			ice_cgu_get_pin_freq_supp(hw, i, input, &freq_supp_num);
>>>+		pins[i].prop.freq_supported_num = freq_supp_num;
>>>+		pins[i].pf = pf;
>>>+	}
>>>+
>>>+	return ret;
>>>+}
>>>+
>>>+/**
>>>+ * ice_dpll_init_rclk_pin - initializes rclk pin information
>>>+ * @pf: board private structure
>>>+ * @pin_type: type of pins being initialized
>>>+ *
>>>+ * Init information for rclk pin, cache them in pf->dplls.rclk.
>>>+ *
>>>+ * Return:
>>>+ * * 0 - success
>>>+ * * negative - init failure reason
>>>+ */
>>>+static int ice_dpll_init_rclk_pin(struct ice_pf *pf)
>>>+{
>>>+	struct ice_dpll_pin *pin = &pf->dplls.rclk;
>>>+	struct device *dev = ice_pf_to_dev(pf);
>>>+
>>>+	pin->prop.board_label = dev_name(dev);
>>
>>What??? Must be some sort of joke, correct?
>>"board_label" should be an actual writing on a board. For syncE, I don't
>>think it makes sense to fill any label. The connection to the netdev
>>should be enough. That is what I do in mlx5.
>>
>>Please drop this.
>>
>
>No, we want a label, as this is recovered clock, will change it to

Okay, so it is recovered clock, so what? I want a lot of things, that
does not make them meaningful.


>package_label but the name will stay for now, this is much more meaningful
>then i.e. "phy0" or "RCLK".

No, dev_name() here is total non-sense!
The label should contain the actual label as for example a writing on a
front panel, board, etc.

Why exactly do you need this? Why a link from netdev to this dpll pin is
not enough for you.

Please describe exactly what you need the label for. Usecases, examples,
etc.

Jakub, if you read this, this is very nice example of a misuse that even
very precisely defined netlink attribute cannot prevent :/


>
>>
>>
>>>+	pin->prop.type = DPLL_PIN_TYPE_SYNCE_ETH_PORT;
>>>+	pin->prop.capabilities |= DPLL_PIN_CAPS_STATE_CAN_CHANGE;
>>>+	pin->pf = pf;
>>>+

[...]


>>>+int ice_dpll_init(struct ice_pf *pf)
>>>+{
>>>+	bool cgu_present = ice_is_feature_supported(pf, ICE_F_CGU);
>>>+	struct ice_dplls *d = &pf->dplls;
>>>+	int err = 0;
>>>+
>>>+	mutex_init(&d->lock);
>>>+	mutex_lock(&d->lock);
>>
>>Seeing pattern like this always triggers questions.
>>Why exactly do you need to lock the mutex here?
>>
>
>Could do it few lines below before the dplls are inited,
>but this would make error path confusing.

See above, you don't need to do this if you register dpll and start the
periodic work only after everything is ready. I believe that you
actually have it like this now.


>
>>
>>>+	err = ice_dpll_init_info(pf, cgu_present);
>>>+	if (err)
>>>+		goto err_exit;
>>>+	err = ice_dpll_init_dpll(pf, &pf->dplls.eec, cgu_present,
>>>+				 DPLL_TYPE_EEC);
>>>+	if (err)
>>>+		goto deinit_info;
>>>+	err = ice_dpll_init_dpll(pf, &pf->dplls.pps, cgu_present,
>>>+				 DPLL_TYPE_PPS);
>>>+	if (err)
>>>+		goto deinit_eec;
>>>+	err = ice_dpll_init_pins(pf, cgu_present);
>>>+	if (err)
>>>+		goto deinit_pps;
>>>+	set_bit(ICE_FLAG_DPLL, pf->flags);
>>>+	if (cgu_present) {
>>>+		err = ice_dpll_init_worker(pf);
>>>+		if (err)
>>>+			goto deinit_pins;
>>>+	}
>>>+	mutex_unlock(&d->lock);
>>>+	dev_info(ice_pf_to_dev(pf), "DPLLs init successful\n");
>>
>>What is this good for? Please avoid polluting dmesg and drop this.
>>
>
>Sure, removed.
>
>>
>>>+
>>>+	return err;
>>>+
>>>+deinit_pins:
>>>+	ice_dpll_deinit_pins(pf, cgu_present);
>>>+deinit_pps:
>>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.pps, cgu_present);
>>>+deinit_eec:
>>>+	ice_dpll_deinit_dpll(pf, &pf->dplls.eec, cgu_present);
>>>+deinit_info:
>>>+	ice_dpll_deinit_info(pf);
>>>+err_exit:
>>>+	clear_bit(ICE_FLAG_DPLL, pf->flags);
>>>+	mutex_unlock(&d->lock);
>>>+	mutex_destroy(&d->lock);
>>>+	dev_warn(ice_pf_to_dev(pf), "DPLLs init failure err:\n");
>>
>>You are missing the err. But why do you need the message?
>>
>
>To give a clue that something went wrong on dpll init.

Yeah, you ignore the err in the caller. That makes sense.
Don't forget to add the "err" :)


>
>>
>>>+
>>>+	return err;


[...]
