Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 772DD122B90
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2019 13:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfLQMdI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Dec 2019 07:33:08 -0500
Received: from mail-eopbgr30050.outbound.protection.outlook.com ([40.107.3.50]:19444
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727926AbfLQMdI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Dec 2019 07:33:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8iDg/Mox9rwBRkWkMFi7xQH024Rl78x5TJQ3SHJgMLQHGG1wbMIvdAg6UZnWVbEJ3maQ4NIvQ6ojrypE31WRGlLXZcCiQb2Hg6cCpLoGt0JR8abLRMXwLvNzRzZLmP+JMBZH3ZIcJ8OBh1alZLG/vXvjhn4UTeErcrAgKAvvgVV/wHrcOIcPNt01Vb0lhpjXTBHRZ8LVqQVjIlt5kdn3m3VFVn6ApPQlnR+R6fhyuqGVJ1GW+1zt1hpHMmjm52IFQs77AVMgfaPKmZTAk5xR4Jg6W53KeZiFA3byVkwV1TMMV4mMS0jrntYXqY1KBqFrapZ1OkIlbGH4yfrhnWi/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxrQQFiB41/w9/nhMHmP+N1gdeP8u8IzpaPFOnIjpS8=;
 b=E+gZPZ/dbCrgXjsxeaE2yM0qVfXmDx7BHg83lrer9YN2OhLPa/+x4rpv+OzT1HXnXC2ZsJGhjyPJJF7OE9VRMU98YFrhPe3qrNoX+Pcnbah9FxIBYtF2zjpQrb3bugh+JtPYquAh61WPar9v/gx23rYMVtr327WizRWRkrhI9H/+wz72UUfNP82soW3yxETIdbNkIVLHqNvRmqMJKOmB9lO2+ftMULGwWb+Q0iI4qyhS5cuwryV928faq86iOGjA4I+6k7Ao+kkXAdK7YXatsrbB6zzMmBn6j1lP1k7ZbFYpk70RSvEyrsrc+FEepYs3JXqzwiObFNOXe6gDh5sBEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxrQQFiB41/w9/nhMHmP+N1gdeP8u8IzpaPFOnIjpS8=;
 b=ktPit2fzRT2eq1vlbssD7oW93B9313n2SqkgHrt1d2mR6SNaKFkxZ9uinnio+hdgE6Nv9PubLazfcnSuZ3dYmAaIYfufqG8VcLhhbWINDm82XQ6ecD9Fon/UZC6Bcv8XreyfqewICslt5mxayWRUDMOAZRwRtQSJmqRTeMUxSic=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3219.eurprd05.prod.outlook.com (10.170.126.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Tue, 17 Dec 2019 12:33:06 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e5c3:58e:7e9:d398]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e5c3:58e:7e9:d398%7]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 12:33:06 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-rc v2 47/48] RDMA/cm: Add Enhanced Connection
 Establishment (ECE) bits
Thread-Topic: [PATCH rdma-rc v2 47/48] RDMA/cm: Add Enhanced Connection
 Establishment (ECE) bits
Thread-Index: AQHVtNYhZG5McucKM0a3+8DG+WJBJA==
Date:   Tue, 17 Dec 2019 12:33:06 +0000
Message-ID: <20191217123303.GF66555@unreal>
References: <20191212093830.316934-1-leon@kernel.org>
 <20191212093830.316934-48-leon@kernel.org>
In-Reply-To: <20191212093830.316934-48-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR04CA0022.eurprd04.prod.outlook.com
 (2603:10a6:208:122::35) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5bef3f6c-38f3-47cc-4c25-08d782ed4428
x-ms-traffictypediagnostic: AM4PR05MB3219:|AM4PR05MB3219:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB3219F4B01839702D25790C90B0500@AM4PR05MB3219.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:131;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(199004)(189003)(6506007)(110136005)(478600001)(8676002)(81156014)(26005)(81166006)(2906002)(54906003)(186003)(6486002)(4326008)(1076003)(71200400001)(66556008)(64756008)(5660300002)(33716001)(66446008)(66946007)(66476007)(6636002)(86362001)(6512007)(9686003)(8936002)(52116002)(316002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3219;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Yi3iYjTheGwBtMAACzI7VYsAkeK1gL+A+kiFQFyMDswoyG0yiRhOc3n8OyKlHVnR/W2ffPp+wvYBe64ZF5nz2hMZJ6ysFB8r7k98d66dsxy9ZIE2MoynhJBezwawr6EKssmX7P5ZiAY4tu0kxboC7sRK+8aYmQ5qcSwFX5Rw8DbxMKzY2kPYv5cX6WlNXhqwu5knZQ85rXByLM8deB9pTfbPoKmiDegexDjw+p2WRuroLkyK3PFhvHxmxQpwgWPijSLwJIKeWQqUAmTepfvvDdEDhDMs45gFt+usEFxJ3GdA4csMI6ErsM0sP+D7VGy0j18OFlih1MAiXZ1oiWzPC4UijYL5/XehZ1m88r2UAP2KyEcpXrEwfzEe2yXTnCKMjY/zNhOpyY4fpcw7+HsjeZR31pjw/Jx8c5CCN/U3yaCRPs4b0fXPJRrnI2bQmTR
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8B5728312EBEB047B076C5FD680B701C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bef3f6c-38f3-47cc-4c25-08d782ed4428
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 12:33:06.1134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6OtoN5bhZdnYQ6YRlua6Z+7m+pMI95WM77uOdSEo6eUJqBPuh2JlsmnLEvCtVstpn3vsbuBaZ7NO/MfPscVdIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3219
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 12, 2019 at 11:38:29AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>
> Extend REQ (request for communications), REP (reply to request
> for communication), rejected reason and SIDR_REP (service ID
> resolution response) structures with hardware vendor ID bits
> according to approved IBA Comment #9434.
>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  include/rdma/ib_cm.h         | 3 ++-
>  include/rdma/ibta_vol1_c12.h | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>


commit 0238bd12e7601ed09725feba43ca2b228ba4d5a3 (HEAD -> rdma-next)
Author: Leon Romanovsky <leonro@mellanox.com>
Date:   Tue Dec 17 14:30:22 2019 +0200

    fixup! RDMA/cm: Add Enhanced Connection Establishment (ECE) bits

    Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

diff --git a/include/rdma/ibta_vol1_c12.h b/include/rdma/ibta_vol1_c12.h
index 6fc4f1b89ca6..d642a040be18 100644
--- a/include/rdma/ibta_vol1_c12.h
+++ b/include/rdma/ibta_vol1_c12.h
@@ -32,6 +32,7 @@

 /* Table 106 REQ Message Contents */
 #define CM_REQ_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_req_msg, 0, 32)
+#define CM_REQ_VENDORID CM_FIELD32_LOC(struct cm_req_msg, 5, 24)
 #define CM_REQ_SERVICE_ID CM_FIELD64_LOC(struct cm_req_msg, 8, 64)
 #define CM_REQ_LOCAL_CA_GUID CM_FIELD64_LOC(struct cm_req_msg, 16, 64)
 #define CM_REQ_LOCAL_Q_KEY CM_FIELD32_LOC(struct cm_req_msg, 28, 32)
(END)

