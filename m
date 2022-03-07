Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6D74D008C
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Mar 2022 14:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbiCGN6V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Mar 2022 08:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbiCGN6V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Mar 2022 08:58:21 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68E1DF6
        for <linux-rdma@vger.kernel.org>; Mon,  7 Mar 2022 05:57:26 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id 185so11941309qkh.1
        for <linux-rdma@vger.kernel.org>; Mon, 07 Mar 2022 05:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=0zAtFwOQpGaEzTET9u88yK3XdMS9i9E0Q0iVw0Y/kng=;
        b=hkypvm1gY6fHIayXK33Q76KQSqOi7vYvHwtOBygjjnLhxQL7jl0nYpd2aaC1TsMVd4
         D7G/IxHOUBgfb9wy7fXz6RNBbUACb/UU342btXYHWwYWJbkpbiv9QKBX1scpnOol3Dxv
         gxncGjNJkLq/+GBVWHAIIOLQ1Vmf8JE5iEvFOFMJmKsdQe+m52Pn47/ElcUg15rG777y
         TNnyPLPpU0bZmDZ4ycTC0c0ws40w0cwKsZ73icocOtrQ8ut57hDz6vUPlXix/D4dd5eO
         onCZMSmwkpnUMEyf8FyNilpEeumbVfZzeAwhxy/U7QKgcoVGtDDoAhVSd0BluGpM5WYm
         6YzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0zAtFwOQpGaEzTET9u88yK3XdMS9i9E0Q0iVw0Y/kng=;
        b=6PkLbXFBMxlKaLXG5HvUwNeG6dIgJijRHCaixp7uRa11RX6BSTP3iLped+KbMVCwUE
         FgcI+Gib9vc8dfyBgDFnlUG7dL4T6SNh5qchNU1q/MuY85AckxQaz+uxfXh8yaqa5cD0
         YfWv4qotGeoALh1c3/K1ctGB6Xc8GGCbiID5tW1gqR7ESyl58fhKWCHiIHII03vQPl59
         5/KcMmT42sQaSu0nzlHX6snvkmDs55qdIPf5M50Ta1s6MX0RgJ31wzCItb+dENYMs5Rl
         SIvoeF7v3Xza9DmPTsMRewJzjgq5IBJoKnjBWGpizkJN2iIG3FngHOrJ8zmagSZRkuAw
         nuAg==
X-Gm-Message-State: AOAM531OdNcpLN8azM7/6f9rahWomiIAB69w4aY4xWl99jQTRFt2MZ9Z
        XYLM+wns6TJk0HmUduGA0t6nf/f5lPG049oIBxTmbhIHuPY=
X-Google-Smtp-Source: ABdhPJwxJoSSQEKwDi4EEOzj0OH9zn1HDlGykfYxg7WnK7AnBc9AwWOBb3UZ9w4X/FpbJsJjb84WOPzqrtpSZXR/xn0=
X-Received: by 2002:a37:f518:0:b0:663:a53:8a5b with SMTP id
 l24-20020a37f518000000b006630a538a5bmr6837435qkk.546.1646661445655; Mon, 07
 Mar 2022 05:57:25 -0800 (PST)
MIME-Version: 1.0
From:   Sylvain Didelot <didelot.sylvain@gmail.com>
Date:   Mon, 7 Mar 2022 14:57:14 +0100
Message-ID: <CAOrWFD8Kb3R0OZ8A04QF4fPdMM6Xa_-sze0tLHboAJnz3SLivw@mail.gmail.com>
Subject: [Question] Is address format "gid" supported by RDMACM with RoCE?
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

I have configured one of my Mellanox network adapters for RoCE:
---
CA 'roceP1p1s0f1'
    CA type: MT4123
    Number of ports: 1
    Firmware version: 20.32.1010
    Hardware version: 0
    Node GUID: 0xb8cef603002d1707
    System image GUID: 0xb8cef603002d1706
    Port 1:
        State: Active
        Physical state: LinkUp
        Rate: 100
        Base lid: 0
        LMC: 0
        SM lid: 0
        Capability mask: 0x00010000
        Port GUID: 0xbacef6fffe2d1707
        Link layer: Ethernet
---

The Infiniband stack was installed from the official Ubuntu repository
(20.04.4 LTS):
---
$ apt search ibverbs
Sorting... Done
Full Text Search... Done
ibverbs-providers/focal,now 28.0-1ubuntu1 arm64 [installed]
  User space provider drivers for libibverbs

ibverbs-utils/focal,now 28.0-1ubuntu1 arm64 [installed]
  Examples for the libibverbs library

libibverbs-dev/focal,now 28.0-1ubuntu1 arm64 [installed]
  Development files for the libibverbs library

libibverbs1/focal,now 28.0-1ubuntu1 arm64 [installed]
  Library for direct userspace use of RDMA (InfiniBand/iWARP)

librdmacm-dev/focal,now 28.0-1ubuntu1 arm64 [installed]
  Development files for the librdmacm library

librdmacm1/focal,now 28.0-1ubuntu1 arm64 [installed]
  Library for managing RDMA connections

rdmacm-utils/focal,now 28.0-1ubuntu1 arm64 [installed]
  Examples for the librdmacm library
---

When I start the ucmatose server with the address format "gid", the
tool fails binding with the error "No such device"

Here is an example of the output:
---
$ cat /sys/class/infiniband/roceP1p1s0f1/ports/1/gids/0
fe80:0000:0000:0000:bace:f6ff:fe2d:1707

$ ucmatose -b fe80:0000:0000:0000:bace:f6ff:fe2d:1707 -P ib -f gid
cmatose: starting server
cmatose: bind address failed: No such device
test complete
return status -1
---

Does rdmacm support connection establishment using GID with RoCE? Or
Is it a known limitation for RoCE?
FYI, the same experiment without RoCE (Link layer: Infiniband) works perfectly.

Thanks for your help and your feedback.

Sylvain Didelot
