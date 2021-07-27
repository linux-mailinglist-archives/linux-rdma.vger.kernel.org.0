Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F4C3D81A7
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 23:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhG0VVD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 17:21:03 -0400
Received: from mail-mw2nam10on2117.outbound.protection.outlook.com ([40.107.94.117]:52288
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233132AbhG0VUz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 17:20:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Do+8HcHKZVXVwluUa+0VGXe5M4MflNp7Sw0wz7A9ocmKq/ROIFo3ul3TN7IiewBp0sHl58WGVQ06e2m/Dsn8o9ezEEr38b7UpphbhXL2V3Lnsu1DFi+hls6qUK6XU4zJ/eQdJr2JRKLPHIApcQnlKBU6wKLLB6mGcQUfu4qFYcG+iGGeyWbmWfv1ZwWLAqK7ufydt3O1uh9bHyygmGAno5kWx9IJYNtkYgYqUjS/+9r/8+UTFdb3kMiYEEyOCdsLSCaXbykAdodTVE8J7yq521IxlVnmBkdPU/Gc9GxzssCkQemUZXrFCru8MQHIN2hMnvy+SJGT7OZEpaHRcnowZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCilMWFb8q+llwQ7XZw4sroa9k7R7FbLIiwy5oVweuQ=;
 b=N5nmLYHellIykaeSPv+59Ncq3VIDK6OWdvNCPt5hrOKwsTo4yPK9wsKQ4y1LRdOL8QwTbPBqhbQbe0CwtKi8VaxnuWSHlXHbN2s2prIZ7mgTJlVmEWQYoMLOM3L3Ouz6RZ/SmREg+ZQa6e75ZFGJukCy2p9QcNE27qOYdzv4alH62uOLcbaic8M6dyGiya0g2IJGTsPsrFoF2bqanrTCe+gLAhMQFF+SpaYYA4BfYjbU7TcYMV6tZpyuEKQIg6Fme+XZOesbKwDhcT2M+9EanYab66IKaLBhx5BIm+LGXX6ukpfa2IGDyAr+PtcQ6oGb+LWc/KUV9BkVk2nu2LL1+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCilMWFb8q+llwQ7XZw4sroa9k7R7FbLIiwy5oVweuQ=;
 b=I6gqRBfKw1XlgzORNF5XKPRFySK9kzNQ5Pob8LgEuUycJQ7YVaRBsUSXW6hIIYMJS3WRlMX66KrsdnSLGq1pN3NoiHjPQ0t+1n52EPpGIufGEIB29wUyu2H/jIICD/yNQqZoFBTweIXBsVyW2SKY2RMMRhJTCj2Ikb4hZZYbdNbzGfu/VZ0lpfAO5JYtw/2cTtQwEjeROGZVOmdkYqe5nLD8CNgTn8CFDTolT77kSSSNZ1Wq2cjVDU0gErJUM3NEzGGa11cBlWOlW5Hdqxo0FLfafMVrEGxidczUx1VjTLcZtZSqAnj2BZ0VpM/4Z+4RJ3x3BfmxcG4KAaOWy8AQ9g==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH0PR01MB7156.prod.exchangelabs.com (2603:10b6:610:fd::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Tue, 27 Jul 2021 21:20:51 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34%5]) with mapi id 15.20.4373.018; Tue, 27 Jul 2021
 21:20:51 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
Subject: RE: NFS RDMA test failure as of 5.14-rc1
Thread-Topic: NFS RDMA test failure as of 5.14-rc1
Thread-Index: AdeC6xneRTsXNTlrTWuqxyNIUrjEqgAHw3HQAACUb4AAAE5b4AAAJPuAAAA+IwAABkXSIA==
Date:   Tue, 27 Jul 2021 21:20:51 +0000
Message-ID: <CH0PR01MB7153BED95409DC4C26CC5A4FF2E99@CH0PR01MB7153.prod.exchangelabs.com>
References: <CH0PR01MB7153D5381BBC3D1D0F146E8AF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CH0PR01MB7153166CD64AE0097B72608CF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CA7DAB52-ED96-4B47-A49D-88C3B8C6F052@oracle.com>
 <CH0PR01MB7153DE8406A68B049FC81EB6F2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <20210727173857.GI1721383@nvidia.com>
 <29236B57-4AEA-4DEA-AC6F-4402FF8A1A83@oracle.com>
In-Reply-To: <29236B57-4AEA-4DEA-AC6F-4402FF8A1A83@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ac6757f-81f1-48af-3ac2-08d951446966
x-ms-traffictypediagnostic: CH0PR01MB7156:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR01MB71564DAABFF648B86B2AFEBBF2E99@CH0PR01MB7156.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Fziqz0BeB5FoUiVWSvDE2SWvfOzG0vl6gWpHqFhoOGepDv1JXo2ZgnNheR/BAOog+ZChFRVW3oqayx5LP14GO94eILuhloBg3aYN/7E5k5f1GPT3kvPDrxItEyqvNscf/K6zcqe5/VjAVrtPgKR0nFuNe/XM5M7hsg0S5OMKRkg0YCW4syTPd+rSbMMwTRLwWc8xSbBiI0M1H76na1M0LxA9CFejmjk82CwEJghW/TMbRfUm1JtV2kfElLCIKnQckr0kkxgqIvIx41lq75nKdWmQcDOd3itdXqXBDQkKbh4EKkptEfZBRHlUa0bqy32aNj026BHp5MTE8g1VxRoBxOy6x/Ov7WIraczVZveItMI8wcdBGkvc9Snhbn2k1ckPT98RBKY/lLYs8RMkY5mM4Z7urm4PagmDoneIRh3qYJLvA3+rZ6fhpUsYEsn2acBInAGMl5t03q9s8wbdkOWgxzfR9PwvOLJrpsQyNAESSIB2hSY0mQnWtIfO/ZwXxXItj+mlzvJhrG8IC+WfJtioc7e4FjsJ6yP70ndnnW/R9VCB6xGQh8U69NMDW1UwyjB76zYiveRMZ9p9R1f6PjcAtSof7NVyfs6ERITx7amN4bnUAQkvtN68jpUB96MXt6LahNGtMyV2IvRnn55KujwBq5noNN2qWPMRNRnHwe3myeH5/Ec7Z/q5npYP75vFxGiPN7fnuQ8IZdPDMfqp7ZQQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39840400004)(366004)(136003)(396003)(110136005)(8936002)(478600001)(66446008)(76116006)(66556008)(66476007)(2906002)(26005)(64756008)(54906003)(186003)(8676002)(38070700005)(66946007)(316002)(9686003)(33656002)(38100700002)(7696005)(122000001)(52536014)(71200400001)(55016002)(4744005)(4326008)(86362001)(5660300002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z6/5/ZIzWvuGlk+ZKTwNtMaQoeLr9vmR7xoeqIDkR4WiCSG++LCKu+vqxUOQ?=
 =?us-ascii?Q?byWICvA2SXP+fxzRgBzbe9/aQc4iEU+OlVx/1jkWqSF8vSeqrRbnUu+Nbn0A?=
 =?us-ascii?Q?Xr1LZHAYKyMNzeZsaXYV+JyLr4/gdHHgs0Kk0M5rW5QbJIT61vxPHE12BOsg?=
 =?us-ascii?Q?ilvjjlaLLjn/vADkNIHVzeP+dYmig4GQeHFMPt0XqeyXAQ+IM5lNWbk7dBoR?=
 =?us-ascii?Q?8OlRw9pK4uSIeJJmHDHtOTbKWP4R6SwvyB5o2A2e3b6bPA9itea3cUfSc9Wp?=
 =?us-ascii?Q?txQYSOEEiL/wbRxf8hnq4iC/WFA13oCWgRz8+90oLt0J2npFOdFhJp19nD1K?=
 =?us-ascii?Q?kH/1Jih63G6A+ZbDOl5YQul+gmYeo8uDtfLkImQO9kirjtJPK1k72KLzxzU8?=
 =?us-ascii?Q?YcTg4N7P4AwZv07BXlkG56qDGeK2V2Hc6RfmRHv37QIjW36qCdFV8uh7czsl?=
 =?us-ascii?Q?5j4bmHlI46ALiECU86ATZp6MuFwRtQR16K9kLKHUpvyjK8Cuh6gaae0i67qp?=
 =?us-ascii?Q?ixPz5t4X6Fv8CB1LCR7DxCCwFsDMX/iTXGYZz+IAuJZKZmogrNUYbuRFSm/V?=
 =?us-ascii?Q?eNtEp9yu1CrDq4HG+9rf6/s1Ob/jCVuZQdSNmuJLRoVUgAsrOu5ynzFsZ3D+?=
 =?us-ascii?Q?kP+A2t9I64IKE3IDbGI2BMTzgVRySmqLaHYynBEclXCE7yYRZHr4FTV1Z1L8?=
 =?us-ascii?Q?B7Hn24qg+cDyfMW5noUKVr5Hrku4otwTPn17raVw2zMUNuFY1UYplbRWTRsW?=
 =?us-ascii?Q?HOB1L7yBY5kKwk/tTxduv20YhFtGAs3oR47o5STzpGDaGcndyNkcKGotHvGg?=
 =?us-ascii?Q?aPY/g3gvZ2WHmmTPmmz5B4ON7+GVW/ej47z6kxo+UQsa1CLxETYWn4ebrx8I?=
 =?us-ascii?Q?w8ku/i4HXyGDe+dgykz/Qtxpe1uTiZ/M/lGxs1yKHt6pjj4oFDqGW2mYdSUo?=
 =?us-ascii?Q?ynHAf45D3b5Zv+1Wx45hMyDZjnrGmcmbD8BsqH7gMHUO6fS0D4jhJhxE1FEp?=
 =?us-ascii?Q?ZX+IKd3QqUTgVwAxiCCFaMFBRmpSI9L63XkRxQ5IDjaQeRn0bxPBf165CGqV?=
 =?us-ascii?Q?O52Bo0EqcsZF4CMm2dUq++LhXsPkt/UGdSKQ7OtgSg+YV4O/udHUJzxazoGR?=
 =?us-ascii?Q?PSM2c8s6z+Eskty5pNa1SW1A7dc4gwMvjNIpudo2QpNtSAA8SjLi3eYLi3yQ?=
 =?us-ascii?Q?aZF6xH8aJLZwDnNp1fV2ZIKeVvLUClAp7NzQcjUPCKqWXzIpAGShmK/aquOX?=
 =?us-ascii?Q?eMhomMM0KnL9sWAyThHEkFw38Qy+IztdJxh8CVfxKRyG2n3uIUUmIsFNEDVw?=
 =?us-ascii?Q?H18=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac6757f-81f1-48af-3ac2-08d951446966
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 21:20:51.6384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: soCVyT1H++pSxSPMhix8eOJy/06xaZ5+vGkN+hrcldqPySFXWx1t/GNSPrh7aalqGy1X1u9L+5M8UAvKrsb1Y0IbXTU/t/+WUAQlCLetsGY14Z0VY03qquW7ZsNd90iO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7156
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > Haakon's original analysis said that this was an INIT->INIT
> > transition, so I'm a bit confused why we lost a RESET->INIT transition
> > in the end?
>=20
> Perhaps the patch should have removed the ib_modify_qp() from
> cma_modify_qp_rtr() instead.
>=20

I think that will work.

Do you want to post a patch and I can test?

Mike
