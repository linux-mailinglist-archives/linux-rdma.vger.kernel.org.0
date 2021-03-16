Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0F733D398
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Mar 2021 13:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhCPMQJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Mar 2021 08:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhCPMP5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Mar 2021 08:15:57 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242ACC06174A
        for <linux-rdma@vger.kernel.org>; Tue, 16 Mar 2021 05:15:57 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id v192so30295047oia.5
        for <linux-rdma@vger.kernel.org>; Tue, 16 Mar 2021 05:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=DN2+iL7ANGEedOF5cgMgGUKtJ+7c++ECTt64NQSgp88=;
        b=HA9uC+D9tgdwKLW8Tju2OK1Ar4QE/xnbE7wm5xHXX/xVFtItLlm6Axp64GOO5HfJz0
         jAFxF0pinKcrIIu4v+DoZa9dhjNuUtHxMRc0dn3vfZKYG6uPYBCXbkrSfrHzUkYUvjTD
         DAbSh3sVFMRgqXFnOhPbB7U7bFNA1BAUifBct125mUouDXOhUyTGt6h+cbCRK34J7VaF
         xySnxvg9Rmj0jzRMsXzO5TQ4kXBCcg3J/JvJnu0u6IrjHMx9I1FYHMjdjJ0HGurB9w91
         zSKhKsAK46AsoS67jFhts+woEOAxMcSM0THDZcz5u/szgTFkXP4qtZK1EzyVGBAsy8zg
         bgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DN2+iL7ANGEedOF5cgMgGUKtJ+7c++ECTt64NQSgp88=;
        b=flPBmfL3fXh541+S3H+dfR2lSIF5ku/RAn9oR9GBf+FDMKwO8B8LsFlSLWMn9EX+vf
         NYuiq9AMpAi0wd3k7blIaefStRH3SjCte5CSeuTqk8m28CaVgXHVSYHAG80wpCnWXKYU
         1/RM70qmplP1LnhkVcfeMJM+TswpQOO0RcLa3Nl9pmEIoztFaUuiiMO1zlfag/n9EryB
         AB0g38U31GMddUXOU4CZBcyB4JZlfPTkrWUniwvCUpxjV/Bn2ktG0pjYfihTKkhmDioJ
         nOQH9CXb4cCPhYWD4yi1sRuLFPNQjqhgcbnvO7CdQB76MOmXVjk/eYSfK3d5K98oryqU
         lnnQ==
X-Gm-Message-State: AOAM533/MgK66AwrQ3ALATsnSc0p1WhgV8ELhjqUiq4sCphI/V1MNlLG
        +A0COnK6tc/46OpFJRa9HEBb3MvXynEVwQpgMB5UraKYNeH0yD93
X-Google-Smtp-Source: ABdhPJyFRPpzk5FEqrJCaFWbYPK3jmue4c8Wo60h3uwt44rVgdKIt0I7DPyOApRDPaL+9bo9IcKgOdUFNPOrGmOIroM=
X-Received: by 2002:aca:df54:: with SMTP id w81mr3273446oig.108.1615896955738;
 Tue, 16 Mar 2021 05:15:55 -0700 (PDT)
MIME-Version: 1.0
From:   "westjoshuaalan@gmail.com" <westjoshuaalan@gmail.com>
Date:   Tue, 16 Mar 2021 06:15:19 -0600
Message-ID: <CAMCTd2ncDaqfgSOov67rAX6-YekFwe_eME-t62ERHiFAEPZ7EA@mail.gmail.com>
Subject: opensm + ceph RDMA = Down OSDs
To:     linux-rdma@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000b61c605bda654e9"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000000b61c605bda654e9
Content-Type: text/plain; charset="UTF-8"

Hello,

I understand that this mailing list may be able to help me with an
issue I am experiencing specific to opensm/infiniband rdma!

Forgive me if I am not in the right place though, if not, I would
appreciate a pointer to the next step in my journey!

I am having a recurring issue where after some period of working
without issue, I come to find several OSDs in my ceph cluster offline,
each reporting the same clock skew error in their systemd unit log
(`systemctl status ceph-osd@##`):
>
> Mar 12 00:39:28 rd240 ceph-osd[1655164]: 2021-03-12T00:39:28.006-0700 7f0d635b2700 -1 monclient: _check_auth_rotating possible clock skew, rotating keys expired way too early (before 2021-03-11T23:39:28.012146-0700)
> Mar 12 00:39:29 rd240 ceph-osd[1655164]: 2021-03-12T00:39:29.006-0700 7f0d635b2700 -1 monclient: _check_auth_rotating possible clock skew, rotating keys expired way too early (before 2021-03-11T23:39:29.012281-0700)
> Mar 12 00:39:30 rd240 ceph-osd[1655164]: 2021-03-12T00:39:30.007-0700 7f0d635b2700 -1 monclient: _check_auth_rotating possible clock skew, rotating keys expired way too early (before 2021-03-11T23:39:30.012420-0700)
>
>  (Ignore the fact it's right at midnight, which I beleive is simply from log rotation.)


When resetting the osds, they all come back online without issue, but
at some point in the future are expected to go down again.

See attached the two opensm logs from the node on which all osd
failures occurred today.

Here is the only message from the opensm master (I have three nodes in
total, opensm running on each, and different opensm priorities for
each port in an attempt to create redundancy)

> Mar 11 19:32:26 717944 [EC430700] 0x01 -> log_send_error: ERR 5411: DR SMP Send completed with error (IB_TIMEOUT) -- dropping
>                         Method 0x1, Attr 0x20, TID 0x11f51
> Mar 11 19:32:26 718212 [EC430700] 0x01 -> Received SMP on a 2 hop path: Initial path = 0,1,3, Return path  = 0,0,0
> Mar 11 19:32:26 718223 [EC430700] 0x01 -> sm_mad_ctrl_send_err_cb: ERR 3113: MAD completed in error (IB_TIMEOUT): SubnGet(SMInfo), attr_mod 0x0, TID 0x11f51
> Mar 11 19:32:26 718227 [EC430700] 0x01 -> sm_mad_ctrl_send_err_cb: ERR 3120: Timeout while getting attribute 0x20 (SMInfo); Possible mis-set mkey?
> Mar 11 19:34:56 733934 [EC430700] 0x01 -> log_send_error: ERR 5411: DR SMP Send completed with error (IB_TIMEOUT) -- dropping
>                         Method 0x1, Attr 0x20, TID 0x11f8d
> Mar 11 19:34:56 733965 [EC430700] 0x01 -> Received SMP on a 2 hop path: Initial path = 0,1,3, Return path  = 0,0,0
> Mar 11 19:34:56 733972 [EC430700] 0x01 -> sm_mad_ctrl_send_err_cb: ERR 3113: MAD completed in error (IB_TIMEOUT): SubnGet(SMInfo), attr_mod 0x0, TID 0x11f8d
> Mar 11 19:34:56 733977 [EC430700] 0x01 -> sm_mad_ctrl_send_err_cb: ERR 3120: Timeout while getting attribute 0x20 (SMInfo); Possible mis-set mkey?
> Mar 11 19:34:56 733993 [EC430700] 0x01 -> log_send_error: ERR 5411: DR SMP Send completed with error (IB_TIMEOUT) -- dropping
>                         Method 0x1, Attr 0x20, TID 0x11f8e
> Mar 11 19:34:56 733999 [EC430700] 0x01 -> Received SMP on a 2 hop path: Initial path = 0,1,2, Return path  = 0,0,0
> Mar 11 19:34:56 734003 [EC430700] 0x01 -> sm_mad_ctrl_send_err_cb: ERR 3113: MAD completed in error (IB_TIMEOUT): SubnGet(SMInfo), attr_mod 0x0, TID 0x11f8e
> Mar 11 19:34:56 734007 [EC430700] 0x01 -> sm_mad_ctrl_send_err_cb: ERR 3120: Timeout while getting attribute 0x20 (SMInfo); Possible mis-set mkey?
> Mar 11 19:35:26 725924 [EC430700] 0x01 -> log_send_error: ERR 5411: DR SMP Send completed with error (IB_TIMEOUT) -- dropping
>                         Method 0x1, Attr 0x20, TID 0x11f99

--> That "Return path = 0,0,0" strikes me as possibly incorrect?
--> This is just repeated until failed ceph osd's restarted


Investigating the "Possible mis-set mkey?" line, I believe it is the
default, as I haven't expressly set it to my memory, but haven't
figured out how to check either.
I suspect the error is in my opensm config..
opensm are each run via:
/etc/init.d/opensm:
>
> ...
> start-stop-daemon --start --quiet --make-pidfile --pidfile /var/run/opensm-0x7cfe900300179b31 --background --exec \
> /usr/sbin/opensm -- \
>
> --daemon \
>
> -g 0x7cfe900300179b31 \
>
> -p /etc/opensm/partitions.conf \
>
> -f /var/log/opensm.0x7cfe900300179b31.log \
>
> --priority 11 \ #changed per port, no overlapping priorities
>
> --port-shifting \
>
> --ucast_cache \
>
> --do_mesh_analysis \
>
> --lmc 0 \
>
> -R ftree,updn,minhop \
>
> --part_enforce both \
>
> --allow_both_pkeys
> ...



Digging into this error, I checked and found iblink error counters as
follows, mainly on (i believe) the IB switch itself?

> # ibqueryerrors
> Errors for "dl380g7 mlx4_0"
>    GUID 0x7cfe900300179b31 port 1: [VL15Dropped == 14] [PortXmitWait == 4294967295]
>    GUID 0x7cfe900300179b32 port 2: [PortXmitWait == 2]
> Errors for "server mlx4_0"
>    GUID 0x2c9030042dff1 port 1: [PortXmitWait == 4294967295]
> Errors for 0x2c903006e29b0 "MF0;ys23ib4:SX6036/U1"
>    GUID 0x2c903006e29b0 port ALL: [LinkErrorRecoveryCounter == 15] [LinkDownedCounter == 48] [PortRcvSwitchRelayErrors == 2461] [PortXmitDiscards == 15854] [VL15Dropped == 5] [PortXmitWait == 4294967295]
>    GUID 0x2c903006e29b0 port 0: [PortXmitWait == 76959324]
>    GUID 0x2c903006e29b0 port 1: [LinkDownedCounter == 8] [PortRcvSwitchRelayErrors == 2] [PortXmitWait == 4294967295]
>    GUID 0x2c903006e29b0 port 2: [LinkDownedCounter == 5] [PortRcvSwitchRelayErrors == 4] [VL15Dropped == 2] [PortXmitWait == 4294967295]
>    GUID 0x2c903006e29b0 port 3: [LinkDownedCounter == 5] [PortRcvSwitchRelayErrors == 2] [VL15Dropped == 3] [PortXmitWait == 4294967295]
>    GUID 0x2c903006e29b0 port 4: [LinkDownedCounter == 8] [PortRcvSwitchRelayErrors == 2] [PortXmitWait == 2]
>    GUID 0x2c903006e29b0 port 5: [SymbolErrorCounter == 65535] [LinkErrorRecoveryCounter == 8] [LinkDownedCounter == 2] [PortRcvSwitchRelayErrors == 149] [PortXmitDiscards == 649] [PortXmitWait == 84704351]
>    GUID 0x2c903006e29b0 port 6: [LinkDownedCounter == 9] [PortRcvSwitchRelayErrors == 2285] [PortXmitDiscards == 14176] [PortXmitWait == 4294967295]
>    GUID 0x2c903006e29b0 port 7: [SymbolErrorCounter == 65535] [LinkErrorRecoveryCounter == 7] [LinkDownedCounter == 2] [PortRcvSwitchRelayErrors == 1]
>    GUID 0x2c903006e29b0 port 8: [LinkDownedCounter == 9] [PortRcvSwitchRelayErrors == 16] [PortXmitDiscards == 1029]
> Errors for "rd240 mlx4_0"
>    GUID 0xe41d2d0300e0bae1 port 1: [PortXmitWait == 4294967295]
>    GUID 0xe41d2d0300e0bae2 port 2: [PortXmitWait == 1]
>
> ## Summary: 4 nodes checked, 4 bad nodes found
> ##          43 ports checked, 14 ports have errors beyond threshold
> ## Thresholds:
> ## Suppressed:



par
I do not have an opensm.conf, instead setting the config via the above
init.d script, but I do have partitions.conf as:
>
> Default=0x7fff, rate=7, mtu=4, scope=2, defmember=full:
>         ALL=full, SELF=full, ALL_SWITCHES=full;
> Default=0x7fff, ipoib, rate=7, mtu=4, scope=2:
> mgid=ff12:401b:ffff::ffff:ffff  # JW from error log
>         mgid=ff12:401b::ffff:ffff       # IPv4 Broadcast address
>         mgid=ff12:401b::1               # IPv4 All Hosts group
>         mgid=ff12:401b::2               # IPv4 All Routers group
>         mgid=ff12:401b::16              # IPv4 IGMP group
>         mgid=ff12:401b::fb              # IPv4 mDNS group
>         mgid=ff12:401b::fc              # IPv4 Multicast Link Local Name Resolution group
>         mgid=ff12:401b::101             # IPv4 NTP group
>         mgid=ff12:401b::202             # IPv4 Sun RPC
>         mgid=ff12:601b::1               # IPv6 All Hosts group
>         mgid=ff12:601b::2               # IPv6 All Routers group
>         mgid=ff12:601b::16              # IPv6 MLDv2-capable Routers group
>         mgid=ff12:601b::fb              # IPv6 mDNS group
>         mgid=ff12:601b::101             # IPv6 NTP group
>         mgid=ff12:601b::202             # IPv6 Sun RPC group
>         mgid=ff12:601b::1:3             # IPv6 Multicast Link Local Name Resolution group
>         ALL=full, SELF=full, ALL_SWITCHES=full;



I am hopeful that this group may be able to point me in the right
direction. I am 100% self taught, and have come a long way, but this
issue has been haunting me for awhile now.
It's not a production cluster, I am just learning and playing with
stuff I find really interesting, but the double edged sword is that
now I am feeling pretty lost...

Any help would be greatly appreciated!

--0000000000000b61c605bda654e9
Content-Type: application/gzip; name="opensm.1.log.gz"
Content-Disposition: attachment; filename="opensm.1.log.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_kmbzaj5v0>
X-Attachment-Id: f_kmbzaj5v0

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
--0000000000000b61c605bda654e9
Content-Type: application/gzip; name="opensm.2.log.gz"
Content-Disposition: attachment; filename="opensm.2.log.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_kmbzak9z1>
X-Attachment-Id: f_kmbzak9z1

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
QNsAAA==
--0000000000000b61c605bda654e9--
