Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05C71CE8A4
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2019 18:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfJGQHy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 7 Oct 2019 12:07:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:3847 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728620AbfJGQHx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Oct 2019 12:07:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 09:07:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,268,1566889200"; 
   d="scan'208";a="222953650"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga002.fm.intel.com with ESMTP; 07 Oct 2019 09:07:35 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 7 Oct 2019 09:07:35 -0700
Received: from fmsmsx123.amr.corp.intel.com ([169.254.7.221]) by
 FMSMSX119.amr.corp.intel.com ([169.254.14.173]) with mapi id 14.03.0439.000;
 Mon, 7 Oct 2019 09:07:35 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: RE: unregister_device messages at shutdown (v5.4-rc)
Thread-Topic: unregister_device messages at shutdown (v5.4-rc)
Thread-Index: AQHVfSW1SYqEvHgVxE29x6oe8BaUa6dPV2VA
Date:   Mon, 7 Oct 2019 16:07:34 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7B6ADDB8B@fmsmsx123.amr.corp.intel.com>
References: <6D3E730A-ED56-4AA9-9BAC-8AD31BB915BB@oracle.com>
In-Reply-To: <6D3E730A-ED56-4AA9-9BAC-8AD31BB915BB@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGM5ZmU3YTAtZDY0NS00ZTFiLWE4ODMtYWNmZTRiMjBhNjU1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNGVVcFpuNmN0V3B2Y2FwTUxHTmtQUVdqVDU0RWxwWEtxazJiZkdQTXBLeDh0TnVzcEZ5MzcxNkxIS3Z1Y0FuaiJ9
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> Subject: unregister_device messages at shutdown (v5.4-rc)
> 
> Not quite sure where to report this.
> 
> Since v5.4-rc1, at shutdown I'm seeing a hang with this message repeated in
> /var/log/messages:
> 
> unregister_netdevice: waiting for ens1f0 to become free. Usage count = 1
> 
> Google turns up this particular failure off and on for the past few years from
> various network devices. It's currently 100% reproducible on my rig.
> 
> ens1f0 is a FastLinq NIC in iWARP mode:
> 
> 01:00.0 Ethernet controller: QLogic Corp. FastLinQ QL41000 Series
> 10/25/40/50GbE Controller (rev 02)
>         Subsystem: QLogic Corp. FastLinQ QL41212H 25GbE Adapter
> 
> 3: ens1f0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 9216 qdisc mq state
> DOWN group default qlen 1000
>     link/ether f4:e9:d4:72:49:f2 brd ff:ff:ff:ff:ff:ff
>     inet 192.168.100.51/24 brd 192.168.100.255 scope global ens1f0
>        valid_lft forever preferred_lft forever
> 
> (the network switch is powered off at the moment).
> 

Perhaps you're hitting the issue addressed in this patch.

https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=for-rc&id=390d3fdcae2da52755b31aa44fcf19ecb5a2488b

