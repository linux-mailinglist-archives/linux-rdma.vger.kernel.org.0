Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A903CEFFA
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 01:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244400AbhGSWxz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 19 Jul 2021 18:53:55 -0400
Received: from smtp.digdes.com ([85.114.5.12]:20745 "EHLO smtp.digdes.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385864AbhGSUHO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Jul 2021 16:07:14 -0400
Received: from DDSM-MAIL01.digdes.com (172.16.100.67) by relay2.digdes.com
 (172.16.96.56) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 19 Jul
 2021 23:47:33 +0300
Received: from DDSM-MAIL01.digdes.com (172.16.100.67) by
 DDSM-MAIL01.digdes.com (172.16.100.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 23:47:32 +0300
Received: from DDSM-MAIL01.digdes.com ([fe80::bcb8:b09e:6891:336a]) by
 ddsm-mail01.digdes.com ([fe80::bcb8:b09e:6891:336a%2]) with mapi id
 15.01.2176.009; Mon, 19 Jul 2021 23:47:32 +0300
From:   Chesnokov Gleb <Chesnokov.G@raidix.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@nvidia.com>,
        "lanevdenoche@gmail.com" <lanevdenoche@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH 1/1] iser-target: Fix handling of
 RDMA_CV_EVENT_ADDR_CHANGE
Thread-Topic: [PATCH 1/1] iser-target: Fix handling of
 RDMA_CV_EVENT_ADDR_CHANGE
Thread-Index: AQHXeN9BrGPA8AdBnUS24KgxTpIoiqtKCs4AgABs1p3///xlAIAAVo5Q
Date:   Mon, 19 Jul 2021 20:47:31 +0000
Message-ID: <1a74041f62f3489b814ce88f8f7f3d73@raidix.com>
References: <20210714182646.112181-1-Chesnokov.G@raidix.com>
 <20210719121302.GA1048368@nvidia.com>
 <2ea098b2bbfc4f5c9e9b590804e0dcb5@raidix.com>,<0e6e8da9-5d14-92ef-39d9-99d7a0792f62@grimberg.me>
In-Reply-To: <0e6e8da9-5d14-92ef-39d9-99d7a0792f62@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.100.61]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> (I also have some vague memory that some bonding events mapped to this
> cma event although the address was still available but that was a long
> time ago so I'm not sure, and the change log says nothing about it...)

The test case where I reproduced the problem with processing RDMA_CM_EVENT_ADDR_CHANGE 
is the disconnection of the active link from bonding under load (through pull out the cable).

With my patch, the bug is not reproduced, the load is not interrupted.

Best regards,
Chesnokov Gleb
