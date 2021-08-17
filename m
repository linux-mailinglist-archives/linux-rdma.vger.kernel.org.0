Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6FE3EE88E
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Aug 2021 10:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbhHQIgE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 17 Aug 2021 04:36:04 -0400
Received: from smtp.digdes.com ([85.114.5.12]:22698 "EHLO smtp.digdes.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234952AbhHQIf5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Aug 2021 04:35:57 -0400
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Aug 2021 04:35:57 EDT
Received: from DDSM-MAIL01.digdes.com (172.16.100.67) by relay2.digdes.com
 (172.16.96.56) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 17 Aug
 2021 11:30:04 +0300
Received: from DDSM-MAIL01.digdes.com (172.16.100.67) by
 DDSM-MAIL01.digdes.com (172.16.100.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 11:30:04 +0300
Received: from DDSM-MAIL01.digdes.com ([fe80::bcb8:b09e:6891:336a]) by
 ddsm-mail01.digdes.com ([fe80::bcb8:b09e:6891:336a%2]) with mapi id
 15.01.2176.009; Tue, 17 Aug 2021 11:30:04 +0300
From:   Chesnokov Gleb <Chesnokov.G@digdes.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@nvidia.com>
CC:     "lanevdenoche@gmail.com" <lanevdenoche@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH 1/1] iser-target: Fix handling of
 RDMA_CV_EVENT_ADDR_CHANGE
Thread-Topic: [PATCH 1/1] iser-target: Fix handling of
 RDMA_CV_EVENT_ADDR_CHANGE
Thread-Index: AQHXeN9BrGPA8AdBnUS24KgxTpIoiqtKCs4AgABs1p3///xlAIAEckoAgABcYwCAB7VNgIAP402AgBCyij4=
Date:   Tue, 17 Aug 2021 08:30:04 +0000
Message-ID: <57cdb944fa6e445c97692328fb2435c0@digdes.com>
References: <20210714182646.112181-1-Chesnokov.G@raidix.com>
 <20210719121302.GA1048368@nvidia.com>
 <2ea098b2bbfc4f5c9e9b590804e0dcb5@raidix.com>
 <0e6e8da9-5d14-92ef-39d9-99d7a0792f62@grimberg.me>
 <20210722142346.GL1117491@nvidia.com>
 <d7cba69f-42f1-c86e-8c01-9ddba87332e8@grimberg.me>
 <20210727173709.GH1721383@nvidia.com>,<4e31b660-822a-5bc9-26e3-76046049695a@grimberg.me>
In-Reply-To: <4e31b660-822a-5bc9-26e3-76046049695a@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.100.54]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>> AFAIK the existing listening ID remains, the notification is
>> informative, it doesn't indicate any CM state has changed.
>
> Gleb, can you confirm that?

In my case, when 2 physical interfaces are bonded and the cable is pulled out for one of them,
the RDMA_CM_EVENT_ADDR_CHANGE event is processed 2 times.

1 for condition isert_np->cm_id == cma_id
        isert_np_cma_handler() is called
        The old cma_id is destroyed and a new one is created
2 for condition isert_np->cm_id != cma_id
        isert_disconnected_handler() is called

As I understand it in this case, RDMA_CM_EVENT_ADDR_CHANGE is not just an informative event.
It is needed to recreate the isert connection (struct isert_conn) for the standby path.
I may be wrong, but the creation of a 'struct isert_conn' is initiated in isert_rdma_accept(),
that is, when the cma_id is created.

Therefore, it seems to me that you need to recreate cma_id,
otherwise who will recreate isert_conn?
