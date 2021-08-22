Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430113F3F19
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Aug 2021 13:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhHVLna (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Aug 2021 07:43:30 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:56468 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233083AbhHVLna (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 22 Aug 2021 07:43:30 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17MBO8P7012225;
        Sun, 22 Aug 2021 04:42:43 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0b-0016f401.pphosted.com with ESMTP id 3ak10mtq07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Aug 2021 04:42:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsmpFS18j4GJexcIHRnm+WO0THnkNfqHwTBSY/LIEdY2KpeBGtiFznMX+tubkOSdRaeDwvEMomHz3Hp8JFGHUOoNr7wLrYY53rKjGPxQcmcsqYIbRRUL/3muUorePbEEDqf/gwgJPx9UI07oHyVeKGzdE4yap3T+Cq27u1erKr+avAeBup+uK5SMwqrg/I0KP81bbWPlKoa0pHZC6/zgk1v7feaDJKW5lMn472Oht/8Z/9sD5QWf1fpKYza8JKHbifVaybLrbehi7J0FQxdLZBGwbiguI6RMjGKCljdHo7FGQ1iaMP74l82J6iW1xTOjs58rFyh3JFJygH8g7ZGT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6DKnRddcOTAhNXH81ImXonvUOOeXjX6IJ0Crwox21w=;
 b=YPzK6/XyTbDvfKp9B5uo2IeCDoDHFnPLnOKofk4u5e01Lx4AKg/z2PGNZ2qpNPjIBlwAp/lJ/st3wuGe1EgmhYu5HFkMbO7wneNWM0hl7bXJkF4p/KQJnIwTxe/BmTY3tP3f0sOUV+y4TV1CHTGWdFbJDdW8iubM0sxQ3rxX8zsQD3LbTa+9h3FVYOp47IZYrE6IAUy/RRge4UJZJNxR4BzZzD5eYT3tmsfo2TT5HFIV+pUW5Mmjt20XgQCGGXrU3flS686gnv/NFsmojzJmQEmHEWlwAtJthRH0bUjce01ItcX0XPdOHaPqUHe8yNZnGMxI8Okf3x2rwxPiE1mzpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6DKnRddcOTAhNXH81ImXonvUOOeXjX6IJ0Crwox21w=;
 b=cE3APnvv68SM7idE/eSlQ4+725ppNOgvnE9xsBHc9scHcXs+T+ncin0BQFQxHHaZuicACgHryEDdle1VMO7dmi9oOW1xZaOBdzbrnrYQExZRjKHShnPvH8daEih9V90du7ByHu87y5kr77ys86KpsKn9YHbJ4Y19bDTr9cnnUBk=
Received: from SJ0PR18MB3882.namprd18.prod.outlook.com (2603:10b6:a03:2c8::13)
 by SJ0PR18MB3803.namprd18.prod.outlook.com (2603:10b6:a03:2e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Sun, 22 Aug
 2021 11:42:38 +0000
Received: from SJ0PR18MB3882.namprd18.prod.outlook.com
 ([fe80::80cb:c908:f6d2:6184]) by SJ0PR18MB3882.namprd18.prod.outlook.com
 ([fe80::80cb:c908:f6d2:6184%4]) with mapi id 15.20.4436.023; Sun, 22 Aug 2021
 11:42:38 +0000
From:   Shai Malin <smalin@marvell.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ariel Elior <aelior@marvell.com>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>,
        "prabhakar.pkin@gmail.com" <prabhakar.pkin@gmail.com>,
        "malin1024@gmail.com" <malin1024@gmail.com>
Subject: Re: [PATCH for-next 0/3][v2] qedr: consider dscp prio for vlan tag
 and update tos
Thread-Topic: [PATCH for-next 0/3][v2] qedr: consider dscp prio for vlan tag
 and update tos
Thread-Index: AdeXSdJfy7Ikv1xRQNO/XFFnfTNUsw==
Date:   Sun, 22 Aug 2021 11:42:38 +0000
Message-ID: <SJ0PR18MB38829F827659C23D2E662DC2CCC39@SJ0PR18MB3882.namprd18.prod.outlook.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c2d0658-7932-4666-733f-08d96561f124
x-ms-traffictypediagnostic: SJ0PR18MB3803:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR18MB3803056C9BFA97970F9708AFCCC39@SJ0PR18MB3803.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UiRCkpCsV/1JFJ15EzhJ5eETnBOZJd8ocNgP7D0IN7BU1maiCpDzQQiFCE8qlQSfmgep1r4mWxx+Su4WvyHmcmXmudn/ZIun8dyIyeittM8mcBa8XD26QyK+BAKRmLlyKdXJsA9y+X3dqkXGd+N05iz+DoyBPOQ9mHXSr43Ep4yQnxAXxulTE6PILcEQGh9JD+00ECzhZd2UxSZXa+pNCYw5qxQ3oSigHoT2buY3Vf7xX7b9vTAJIC4EEUtuD3ok24lFA3wRm/1/ESkfeNtmHURRQ+FpQNg5lkBkRAZOfDVr8dDy8xvnYvyc1BJgvck2XqzDtVOlsWapWCUFtsIwiC2tHiDu7nCT6VRasmzSOPrVahp9cJRu+bYpQe12hJUnzEbNh18R83ZnmZ6A8r1+ZuRvFbkR5xELigSxnZ1XbRyByO3cZhOHT5EqZ5pHO3FZUKo/p0nDsLA+BY9q9MbmMoR+cmSehACHHNiekFT4/cauV//RGBJ12hPC4E05YTyLbhq9+9MEv97mvR8Wy6pWXkwy3N+NC3W5+CbnxirUz8AS82n8KwHEOmaGz8Tfuz6AnlTu2hJkVdUevRRNC/YnSnt9oyk4Gtvuf8vxrSbDYktBe6B3+CC+s4JIeLv8jjpF+anGsDBbffoGpZ90zfb8yojaCPh6Egq4oiWlc1eHX74bBH0crxMrhJVlAIDiNjEGZ8mkBb9jWuXuHCMsniM3hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB3882.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(39850400004)(346002)(66446008)(122000001)(66556008)(76116006)(66946007)(64756008)(8676002)(55016002)(38070700005)(66476007)(26005)(38100700002)(6506007)(8936002)(5660300002)(71200400001)(9686003)(186003)(52536014)(4326008)(33656002)(110136005)(7696005)(4744005)(478600001)(86362001)(15650500001)(54906003)(83380400001)(316002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kYi807Ich/EToJy909mMZMwd3ixx3CWUjCdTKge0PJU/Jyzf2oOhflwLl0vZ?=
 =?us-ascii?Q?Mp0vAenbkbNqPYYhZCeu1ieX56Bz5AcaeAny8EcgTafReQBivd20K5K8T4Sz?=
 =?us-ascii?Q?EhVYnfkjzd8o8ak9s5y+RT7AXPh7GVO8LXsJ/Ji18+nQhgZckSc15OfTUh+s?=
 =?us-ascii?Q?l8JzNNDQBE713mjnWUfIvFCtdl8um5by/b9dsBPdj1IJjYwzV93e9uXGjhI7?=
 =?us-ascii?Q?ffmGdKwuBBMldDjb044brPab1PxEKheX+X6fFABHdcZxY+UWh4eNFd9biTe6?=
 =?us-ascii?Q?KQFpJadpN5sI9/KvuHcoUKDnWHRmTFdlseOV/Shy0fMgqtXnQQ/Em8hfzvib?=
 =?us-ascii?Q?mpdXqg+tWvaWTK7TkDOn7X0FV86H2ABwRt+zORv7ex3Lv2gtASuuhSrGLNyl?=
 =?us-ascii?Q?SiolKALKpAyzrfBd6aj882J6K8Ib9zorxVAYcTVByykdLJIYDwzGjPfXd+FR?=
 =?us-ascii?Q?bVoe+ltdVgs7tZBTNCC4Bv7NE1c8IPoxKPeyZ7tDkrAx+5xdXlgI4jEVuu0f?=
 =?us-ascii?Q?c6GKU5v1h/Q/W5jTC5C8XmqeZPJtmP289ma8okstvbjt4ea9aEEl1/aiUWBd?=
 =?us-ascii?Q?CqcVJoxca8tyYLkVd/shBTk0Is8Jm5ymIUl6pqD6FZ5wh51x66R1kE6cdn0k?=
 =?us-ascii?Q?003sYfr7fbkt5jmd5ASORwTfBTxvHPHVIBpEYftGfpF6+CuaNlQmi+MOOZ1X?=
 =?us-ascii?Q?g1HE+xPDZzjCFEsA05MU5UHOlHCCUZAYyZGlCvwgSOoEsyYBi/ebN4Jh8UU/?=
 =?us-ascii?Q?Ls0C90pc7+P1yG0WuIYFyz1ch0QtY8UYPie3ay2J4F/5gpScISshguApxeXE?=
 =?us-ascii?Q?qisvRAmcU65zTSFxotvKuwz2b3a1Ii2bACKnstB/mhRSWw1kzLITt7DlsEvy?=
 =?us-ascii?Q?xKo7IyRYGumCRUv5JmqQ48gh+GT20fks7msDO9BKy47+joBe2zQ5t2l8k8H8?=
 =?us-ascii?Q?E6ymEcTMTmq2DET/CJOQvIJf4/qFKzk9iKjwUPv12ZUbyuSrFlEDjsXvfrnM?=
 =?us-ascii?Q?l8bBQ2Rb+eVkoNgThe1f9f6M6vIcYrtbHuS7/MPiAp0TXfjUkbD42jK4TOGR?=
 =?us-ascii?Q?hec/rCoiwkOJ+9AVtB81pzWv9udecLd8mVu9H27cLaApgBOjrHst05pFCMIv?=
 =?us-ascii?Q?1+sj4q4MuBzMhgI+2aRf+VvEiYyzTh36yHaXSeAipetvshaOS71cWLJXdjww?=
 =?us-ascii?Q?NXNzSiH1oFXWM9G4FbxMMzqJ89tVUfR0vbKmdnzs/rHr9iMPpy+Ui9EbdClF?=
 =?us-ascii?Q?iC0AUvE7W3ogqNIc6/H9X5GRKr5C91OI1KL2KHNi6ce/ABtQ/XhePrz/lCjx?=
 =?us-ascii?Q?oVuN4PTIX6da3pTU1tYU+D4k?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB3882.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2d0658-7932-4666-733f-08d96561f124
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2021 11:42:38.0909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngLm7840eiHvs6i1rDMIog7ahmAhA13Q3zkgDSYt6piNZZkpnGepOpffhuZVnn/9SPoXD8XThmSqhvyMZUnEzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3803
X-Proofpoint-GUID: lB321cIGz1kIGJi6wLk2TVrnXol148Wz
X-Proofpoint-ORIG-GUID: lB321cIGz1kIGJi6wLk2TVrnXol148Wz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-21_11,2021-08-20_03,2020-04-07_01
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 20 Aug 2021 21:04:00 -0300 Jason Gunthorpe wrote:
> On Fri, Aug 20, 2021 at 11:02:51AM -0700, Jakub Kicinski wrote:
> > On Fri, 20 Aug 2021 14:49:44 -0300 Jason Gunthorpe wrote:
> > > Since this is mostly netdev stuff can someone from netdev ack this if
> > > you want it to go through the rdma tree?
> >
> > It'd be great to get it CCed to netdev@ for that.
>=20
> Indeed, Shai please respost it.
>=20
> Jason

Jason, Jakub,
Please don't accept the content of the current version.=20
We will expand the content of the series and we will send the updated one.

Shai

