Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16CF319FD4
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 14:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhBLNZY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 08:25:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231294AbhBLNZS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Feb 2021 08:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613136232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2K4eD5iEblzJfgYCK4wOOctNKLxA3GPEN43kQ75TlXE=;
        b=D+R2KAHtuelAQDln16qywJ7WIGlkzQffqqaPGo2btKxRRbBDDx4iV0HkOmyM/JFT65yzXB
        dzPqR+DEZ+x98rupkk+pLaOpUPbpPhLRrE29MKQb8sWfr60LhMQs02KKwCn89ZULYTSE1I
        1nSQPGxdUWVpvMSaOwjWfNs/B8/qBGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-WMORDcrFMi2RdKb0Q1Zbrw-1; Fri, 12 Feb 2021 08:23:50 -0500
X-MC-Unique: WMORDcrFMi2RdKb0Q1Zbrw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 085676EE20;
        Fri, 12 Feb 2021 13:23:49 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A1E2B39A50;
        Fri, 12 Feb 2021 13:23:48 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Bernard Metzler" <BMT@zurich.ibm.com>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: directing soft iWARP traffic through a secure tunnel
Date:   Fri, 12 Feb 2021 08:23:47 -0500
Message-ID: <42736765-35DA-454E-AF9B-0484D98C821A@redhat.com>
In-Reply-To: <OFCA489C99.24705C66-ON0025867A.004929F2-0025867A.004929F9@notes.na.collabserv.com>
References: <4B1D8641-3971-409C-B730-012EDE4D3AEB@oracle.com>
 <61EFD7EA-FA16-4AA1-B92F-0B0D4CC697AB@oracle.com>
 <OFE25AAD0A.3B8CE2E0-ON0025867A.0043F201-0025867A.00455111@notes.na.collabserv.com>
 <OFCA489C99.24705C66-ON0025867A.004929F2-0025867A.004929F9@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12 Feb 2021, at 8:19, Bernard Metzler wrote:

> How does this tunnel device look like? What does
> ifconfig or ip show? Probably NOARP and no
> HW address?

right:

# ip link show tun0
3: tun0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc 
fq_codel state UNKNOWN mode DEFAULT group default qlen 500

# ifconfig tun0
tun0: flags=4305<UP,POINTOPOINT,RUNNING,NOARP,MULTICAST>  mtu 1500
         inet6 fe80::6bbf:1def:b134:2eef  prefixlen 64  scopeid 
0x20<link>
         inet6 fd51:5f56:d79b:a64e:64cc:5641:2916:7c4  prefixlen 64  
scopeid 0x0<global>
         unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  
txqueuelen 500  (UNSPEC)
         RX packets 751  bytes 118096 (115.3 KiB)
         RX errors 0  dropped 0  overruns 0  frame 0
         TX packets 781  bytes 124142 (121.2 KiB)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

> Or should I better setup a VPN client to your network
> to see what is needed?

I can provide you with an openvpn config file that you can use to 
connect to
our network under separate cover if you'd like.

Ben

