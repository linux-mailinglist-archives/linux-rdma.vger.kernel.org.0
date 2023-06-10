Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083FF72AD3E
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Jun 2023 18:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjFJQWS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 10 Jun 2023 12:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFJQWR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 10 Jun 2023 12:22:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAFF30F5
        for <linux-rdma@vger.kernel.org>; Sat, 10 Jun 2023 09:22:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9788faaca2dso472941866b.0
        for <linux-rdma@vger.kernel.org>; Sat, 10 Jun 2023 09:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1686414132; x=1689006132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kx5pKruNSrU27aJ8jGqQPfU6y7ApLJM2wsxoi+1ZEN4=;
        b=lmdjvR+23NrbWloMWGFrEdM7Gs4oUsnXjoqdfduB0a+TiRA56vu/8YfNlmcKUhHVBC
         NYOOad07Uf6Uzgun9OvMZx9EgkC99LouNoeRXtQ4fiYyOJiHoO9uUcCblcKU7sbbcob0
         eRyDlTOfvSSpmyFsUaHf4OamIYBHrlUQ2d1VdXnEWfysZ64Lit1MoB6JOc6tn8WdsPyY
         IQk8Gji0H9ERvpPExfkcx1xWGYT/gR1RLssH6QYTp7gSnF89E/D0bkyo8P+6IfaeGD7Z
         ohRwuvJMBWz556EEU76WcbeT6BsunEpw/cstI9xgVTEaSw+gZ5VXBliIT8Tmf5s5hSMA
         bidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686414132; x=1689006132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx5pKruNSrU27aJ8jGqQPfU6y7ApLJM2wsxoi+1ZEN4=;
        b=EvmAjOnKGvU+9RqPBXeDCH91WUhM17H2PKnMonViq0WiAXWEho/gVk4vHaZTZs7NjX
         wMktyz77WvZsCljZEzPn4cPy+p7I4oaaUON34QgE+vxyEIBOrsN2MQRB0W84/Lxws8yn
         Sr+3ET+RCZAodCZ/MTYLsB5HDwR2pltpwqUAbzGt+86WPC29YIirWzCwEEJiXNVlwbbU
         Fo9jDapjV0DzEPq9oklr6HH5YeyUIxJen8Q2a2nQIvv1rigIxycOzh+VS57k79Yu4aoE
         KxYlQ/baXPTrTiLofr4hqrE11+/IrUPJsJhQHnuhsSt0kgg7pBMmitrkJZr5Tz1j34df
         Rwaw==
X-Gm-Message-State: AC+VfDxh5bmRTZ1/EgVMumDfDMTRUeYSohyXcXAVGjspzsGCzs3/Y9J3
        lyiHjEqUmuWYN1OG6JnzXvk7jQ==
X-Google-Smtp-Source: ACHHUZ44O/6CAD+E974nX8FE7PkvlcYhxH5tQj6WeQoLOh5GC1uEq4yf9xej6n0yI2WCBic22/NrLA==
X-Received: by 2002:a17:907:1626:b0:96f:e7cf:5004 with SMTP id hb38-20020a170907162600b0096fe7cf5004mr4830407ejc.73.1686414131776;
        Sat, 10 Jun 2023 09:22:11 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id sa9-20020a170906eda900b00974612a9837sm2730051ejb.20.2023.06.10.09.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 09:22:10 -0700 (PDT)
Date:   Sat, 10 Jun 2023 18:22:09 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc:     kuba@kernel.org, vadfed@meta.com, jonathan.lemon@gmail.com,
        pabeni@redhat.com, corbet@lwn.net, davem@davemloft.net,
        edumazet@google.com, vadfed@fb.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
        richardcochran@gmail.com, sj@kernel.org, javierm@redhat.com,
        ricardo.canuelo@collabora.com, mst@redhat.com, tzimmermann@suse.de,
        michal.michalik@intel.com, gregkh@linuxfoundation.org,
        jacek.lawrynowicz@linux.intel.com, airlied@redhat.com,
        ogabbay@kernel.org, arnd@arndb.de, nipun.gupta@amd.com,
        axboe@kernel.dk, linux@zary.sk, masahiroy@kernel.org,
        benjamin.tissoires@redhat.com, geert+renesas@glider.be,
        milena.olech@intel.com, kuniyu@amazon.com, liuhangbin@gmail.com,
        hkallweit1@gmail.com, andy.ren@getcruise.com, razor@blackwall.org,
        idosch@nvidia.com, lucien.xin@gmail.com, nicolas.dichtel@6wind.com,
        phil@nwl.cc, claudiajkang@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, poros@redhat.com,
        mschmidt@redhat.com, linux-clk@vger.kernel.org,
        vadim.fedorenko@linux.dev
Subject: Re: [RFC PATCH v8 02/10] dpll: spec: Add Netlink spec in YAML
Message-ID: <ZISjMUcpmUTBXIOA@nanopsycho>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
 <20230609121853.3607724-3-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609121853.3607724-3-arkadiusz.kubalewski@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fri, Jun 09, 2023 at 02:18:45PM CEST, arkadiusz.kubalewski@intel.com wrote:
>Add a protocol spec for DPLL.
>Add code generated from the spec.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>Signed-off-by: Michal Michalik <michal.michalik@intel.com>
>Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> Documentation/netlink/specs/dpll.yaml | 466 ++++++++++++++++++++++++++
> drivers/dpll/dpll_nl.c                | 161 +++++++++
> drivers/dpll/dpll_nl.h                |  50 +++
> include/uapi/linux/dpll.h             | 184 ++++++++++
> 4 files changed, 861 insertions(+)
> create mode 100644 Documentation/netlink/specs/dpll.yaml
> create mode 100644 drivers/dpll/dpll_nl.c
> create mode 100644 drivers/dpll/dpll_nl.h
> create mode 100644 include/uapi/linux/dpll.h
>
>diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
>new file mode 100644
>index 000000000000..f7317003d312
>--- /dev/null
>+++ b/Documentation/netlink/specs/dpll.yaml
>@@ -0,0 +1,466 @@
>+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
>+
>+name: dpll
>+
>+doc: DPLL subsystem.
>+
>+definitions:
>+  -
>+    type: enum
>+    name: mode
>+    doc: |
>+      working-modes a dpll can support, differentiate if and how dpll selects

s/working-modes/working modes/
s/differentiate/differentiates/
?


>+      one of its inputs to syntonize with it, valid values for DPLL_A_MODE
>+      attribute
>+    entries:
>+      -
>+        name: manual
>+        doc: input can be only selected by sending a request to dpll
>+        value: 1
>+      -
>+        name: automatic
>+        doc: highest prio, valid input, auto selected by dpll

s/valid input, auto selected by dpll/input pin auto selected by dpll/
?


>+      -
>+        name: holdover
>+        doc: dpll forced into holdover mode
>+      -
>+        name: freerun
>+        doc: dpll driven on system clk

Thinking about modes "holdover" and "freerun".
1) You don't use them anywhere in this patchset, please remove them
   until they are needed. ptp_ocp and ice uses automatic, mlx5 uses
   manual. Btw, are there any other unused parts of UAPI? If yes, could
   you please remove them too?

2) I don't think it is correct to have them.
   a) to achieve holdover:
      if state is LOCKED_HO_ACQ you just disconnect all input pins.
   b) to achieve freerun:
      if state LOCKED you just disconnect all input pins.
   So don't mangle the mode with status.


>+    render-max: true
>+  -
>+    type: enum
>+    name: lock-status
>+    doc: |
>+      provides information of dpll device lock status, valid values for
>+      DPLL_A_LOCK_STATUS attribute
>+    entries:
>+      -
>+        name: unlocked
>+        doc: |
>+          dpll was not yet locked to any valid input (or is in mode:
>+            DPLL_MODE_FREERUN)

Don't forget to remove the mention of mode freerun from here.


>+        value: 1
>+      -
>+        name: locked
>+        doc: |
>+          dpll is locked to a valid signal, but no holdover available
>+      -
>+        name: locked-ho-acq
>+        doc: |
>+          dpll is locked and holdover acquired
>+      -
>+        name: holdover
>+        doc: |
>+          dpll is in holdover state - lost a valid lock or was forced
>+          by selecting DPLL_MODE_HOLDOVER mode (latter possible only
>+          when dpll lock-state was already DPLL_LOCK_STATUS_LOCKED,
>+          if dpll lock-state was not DPLL_LOCK_STATUS_LOCKED, the
>+          dpll's lock-state shall remain DPLL_LOCK_STATUS_UNLOCKED
>+          even if DPLL_MODE_HOLDOVER was requested)

Don't forget to remove the mention of mode holdover from here.


>+    render-max: true
>+  -
>+    type: const
>+    name: temp-divider
>+    value: 1000
>+    doc: |
>+      temperature divider allowing userspace to calculate the
>+      temperature as float with three digit decimal precision.
>+      Value of (DPLL_A_TEMP / DPLL_TEMP_DIVIDER) is integer part of
>+      temperature value.
>+      Value of (DPLL_A_TEMP % DPLL_TEMP_DIVIDER) is fractional part of
>+      temperature value.
>+  -
>+    type: enum
>+    name: type
>+    doc: type of dpll, valid values for DPLL_A_TYPE attribute
>+    entries:
>+      -
>+        name: pps
>+        doc: dpll produces Pulse-Per-Second signal
>+        value: 1
>+      -
>+        name: eec
>+        doc: dpll drives the Ethernet Equipment Clock
>+    render-max: true
>+  -
>+    type: enum
>+    name: pin-type
>+    doc: |
>+      defines possible types of a pin, valid values for DPLL_A_PIN_TYPE
>+      attribute
>+    entries:
>+      -
>+        name: mux
>+        doc: aggregates another layer of selectable pins
>+        value: 1
>+      -
>+        name: ext
>+        doc: external input
>+      -
>+        name: synce-eth-port
>+        doc: ethernet port PHY's recovered clock
>+      -
>+        name: int-oscillator
>+        doc: device internal oscillator
>+      -
>+        name: gnss
>+        doc: GNSS recovered clock
>+    render-max: true
>+  -
>+    type: enum
>+    name: pin-direction
>+    doc: |
>+      defines possible direction of a pin, valid values for
>+      DPLL_A_PIN_DIRECTION attribute
>+    entries:
>+      -
>+        name: input
>+        doc: pin used as a input of a signal

I don't think I have any objections against "input", but out of
curiosity, why you changed that from "source"?


>+        value: 1
>+      -
>+        name: output
>+        doc: pin used to output the signal
>+    render-max: true
>+  -
>+    type: const
>+    name: pin-frequency-1-hz
>+    value: 1
>+  -
>+    type: const
>+    name: pin-frequency-10-khz
>+    value: 10000
>+  -
>+    type: const
>+    name: pin-frequency-77_5-khz
>+    value: 77500
>+  -
>+    type: const
>+    name: pin-frequency-10-mhz
>+    value: 10000000
>+  -
>+    type: enum
>+    name: pin-state
>+    doc: |
>+      defines possible states of a pin, valid values for
>+      DPLL_A_PIN_STATE attribute
>+    entries:
>+      -
>+        name: connected
>+        doc: pin connected, active input of phase locked loop
>+        value: 1
>+      -
>+        name: disconnected
>+        doc: pin disconnected, not considered as a valid input
>+      -
>+        name: selectable
>+        doc: pin enabled for automatic input selection
>+    render-max: true
>+  -
>+    type: flags
>+    name: pin-caps
>+    doc: |
>+      defines possible capabilities of a pin, valid flags on
>+      DPLL_A_PIN_CAPS attribute
>+    entries:
>+      -
>+        name: direction-can-change
>+      -
>+        name: priority-can-change
>+      -
>+        name: state-can-change
>+
>+attribute-sets:
>+  -
>+    name: dpll
>+    enum-name: dpll_a
>+    attributes:
>+      -
>+        name: id
>+        type: u32
>+        value: 1
>+      -
>+        name: module-name
>+        type: string
>+      -
>+        name: clock-id
>+        type: u64
>+      -
>+        name: mode
>+        type: u8
>+        enum: mode
>+      -
>+        name: mode-supported
>+        type: u8
>+        enum: mode
>+        multi-attr: true
>+      -
>+        name: lock-status
>+        type: u8
>+        enum: lock-status
>+      -
>+        name: temp
>+        type: s32
>+      -
>+        name: type
>+        type: u8
>+        enum: type
>+      -
>+        name: pin-id
>+        type: u32
>+      -
>+        name: pin-board-label
>+        type: string
>+      -
>+        name: pin-panel-label
>+        type: string
>+      -
>+        name: pin-package-label
>+        type: string

Wouldn't it make sense to add some small documentation blocks to the
attrs? IDK.


>+      -
>+        name: pin-type
>+        type: u8
>+        enum: pin-type
>+      -
>+        name: pin-direction
>+        type: u8
>+        enum: pin-direction
>+      -
>+        name: pin-frequency
>+        type: u64
>+      -
>+        name: pin-frequency-supported
>+        type: nest
>+        multi-attr: true
>+        nested-attributes: pin-frequency-range
>+      -
>+        name: pin-frequency-min
>+        type: u64
>+      -
>+        name: pin-frequency-max
>+        type: u64
>+      -
>+        name: pin-prio
>+        type: u32
>+      -
>+        name: pin-state
>+        type: u8
>+        enum: pin-state
>+      -
>+        name: pin-dpll-caps
>+        type: u32
>+      -
>+        name: pin-parent
>+        type: nest
>+        multi-attr: true
>+        nested-attributes: pin-parent
>+  -
>+    name: pin-parent
>+    subset-of: dpll
>+    attributes:
>+      -
>+        name: id
>+        type: u32
>+      -
>+        name: pin-direction
>+        type: u8
>+      -
>+        name: pin-prio
>+        type: u32
>+      -
>+        name: pin-state
>+        type: u8
>+      -
>+        name: pin-id
>+        type: u32
>+
>+  -
>+    name: pin-frequency-range
>+    subset-of: dpll
>+    attributes:
>+      -
>+        name: pin-frequency-min
>+        type: u64
>+      -
>+        name: pin-frequency-max
>+        type: u64

[...]
