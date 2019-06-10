Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D85A13BD3E
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 21:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389201AbfFJT63 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 10 Jun 2019 15:58:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:56452 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389170AbfFJT63 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 15:58:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 12:58:28 -0700
X-ExtLoop1: 1
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga005.jf.intel.com with ESMTP; 10 Jun 2019 12:58:28 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 10 Jun 2019 12:58:28 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.79]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.233]) with mapi id 14.03.0415.000;
 Mon, 10 Jun 2019 12:58:28 -0700
From:   "Hefty, Sean" <sean.hefty@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Eric Biggers <ebiggers@kernel.org>
CC:     syzbot <syzbot+e5579222b6a3edd96522@syzkaller.appspotmail.com>,
        "dasaratharaman.chandramouli@intel.com" 
        <dasaratharaman.chandramouli@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "parav@mellanox.com" <parav@mellanox.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: RE: WARNING: bad unlock balance in ucma_event_handler
Thread-Topic: WARNING: bad unlock balance in ucma_event_handler
Thread-Index: AQHVH70r3ZnP/JtE/Uij3ZacQcoN06aVwI4A//+McGA=
Date:   Mon, 10 Jun 2019 19:58:27 +0000
Message-ID: <1828884A29C6694DAF28B7E6B8A82373B3E99E60@ORSMSX109.amr.corp.intel.com>
References: <000000000000af6530056e863794@google.com>
 <20180613170543.GB30019@ziepe.ca> <20190610184853.GG63833@gmail.com>
 <20190610194732.GH18468@ziepe.ca>
In-Reply-To: <20190610194732.GH18468@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmFlNGYyMDgtNzFmOS00M2JhLWFjN2QtNjYzZjcwMjVjYmVhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTG1mRU5YQUcxYVwvSVRNTFJBRkY4ajRzZDM4TTg2bFRONmlTcUprQldvMVo3U0FOaUhOTDZ3XC81UmYzNUoxbWhuIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> That is as far as I can get, trying to figure out how to rework
> ctx->file to be properly ref counted, accessed and locked, is a major
> task.. I don't even know right now what migrate_id is supposed to be
> for :(

By default, events for a new connection (rdma_cm_id) go to the fd (rdma_cm_event_channel) associated with the listen.  This allows migrating those events to a different fd.

- Sean
