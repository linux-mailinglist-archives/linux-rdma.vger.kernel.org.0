Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F933DAAE6
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 20:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhG2S21 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 14:28:27 -0400
Received: from mail-mw2nam12on2120.outbound.protection.outlook.com ([40.107.244.120]:12256
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229807AbhG2S2Z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jul 2021 14:28:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPg5/oYq9dhX96/ChIfJ3sH/kcEZDvIESj11V1RW1fEbfemtijDgIXaGzxzmHxQtBypmeSzpQBPf0gCqU78KDsFQVKovKBAZZWJH49wBZR4OvvS+rLJwY/aR895AFYxd4OqkxyCT4GoGQ68vaxHCrzSKf9+9qsmjsYqBfy6ef4c41ifEuCTUhOdJAUD5SiT8PY8OlcIQ6rxJHBjZ7DhXYzV49G6zicJB6F+XYMghqryk4Qo9ATo8ZOuu7kwqscjHqvA7q8qpn655RN9CiaxOi4pLLb80wnNXwNyyY5aoZKemS2SOwsyO4psgDloOJQG+rX3j+OxmlW5A3PlFKKfJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+EGjvShBE76Vr0H7eyShwgynS1fEvvPm+QEF/ZePjQ=;
 b=YG24ro18ZfaY5CtkJt2oJlbF6BEzUdEl63CCDNwc9VsJSwM2ohkmYInq/79WyK91S4/MVuZ3CXwRVj9yuSJt+IizCrAHRrcb9Cij2rYEi+1oVizIfBOe3mjpYk5ZSyyyAhE6cQSO60i5EMihNnfkWBz9Vkoz+W/TCqYbmOy6+sFp353hqu43weqDByWI4PJo+axriq89GwhaFYsasbPDSGpd2h8bQ2LIwLysCXzEiOzLwZk7++X46yNUOGnKTdBkBRUSW7nlu2OzVi2FLRmxKxtDfoZPqJXhiZBhFl5Sp/bBiT3vhbiTLatHZtFrnQr1KTaDg6/9yfbuZwK+qmtQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+EGjvShBE76Vr0H7eyShwgynS1fEvvPm+QEF/ZePjQ=;
 b=eqFyakxKbiQZZtR/w5FOgDk5M+62h6HYL+Shg2wZaNnHK6ijUSAT5W4opbsDynAm9xx/FQucQJMWIZPrRW+uHPqMSdjscbO/o7/9kTkVjnhwW2Bcqh+2OvpbmnMYCzZErMkimi2WOeddZ2NXZysmNVqmThlMrEdX9p4LvHYKVOiPqhLpTsu0uKbGCzBMg/iy4nIq7DJ9XjX5YyrMwRfXG7zEwoJHcf0HXeueVV/pADeZD/rWyPp+1RoT9zQxqrgYXtbpscSEDp6VsDMiwooXWNzOwGB0io/3oVnfiPm+TFgvvVqUWGRau4P4DH5a544LLr1wU1GyHfZzkobLF9VNMw==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH0PR01MB6890.prod.exchangelabs.com (2603:10b6:610:103::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.17; Thu, 29 Jul 2021 18:28:20 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34%5]) with mapi id 15.20.4373.022; Thu, 29 Jul 2021
 18:28:20 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Haakon Bugge <haakon.bugge@oracle.com>
Subject: RE: NFS RDMA test failure as of 5.14-rc1
Thread-Topic: NFS RDMA test failure as of 5.14-rc1
Thread-Index: AdeC6xneRTsXNTlrTWuqxyNIUrjEqgAOO93QACMdPeAACJMjAAA1KQDw
Date:   Thu, 29 Jul 2021 18:28:20 +0000
Message-ID: <CH0PR01MB7153AC0E62FCE1E9C4C82AD6F2EB9@CH0PR01MB7153.prod.exchangelabs.com>
References: <CH0PR01MB7153D5381BBC3D1D0F146E8AF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CH0PR01MB715358BA093A504AED855CCBF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CH0PR01MB71535949BACC7C43261EDAD2F2EA9@CH0PR01MB7153.prod.exchangelabs.com>
 <20210728170540.GA2316423@nvidia.com>
In-Reply-To: <20210728170540.GA2316423@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15cddfa3-aef8-4c23-71f6-08d952bea47b
x-ms-traffictypediagnostic: CH0PR01MB6890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR01MB6890000D57F0B5D762BBFCA2F2EB9@CH0PR01MB6890.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0iKDZSqjeMvqx3rihtWnqgDFWAPOf0pH5YpCNhNEznX5OJ4vclOvtDYguddUfWLvOWOCOwf+w+X3qSupA2RGoKL1d1lIlUc2U0POEJ9wdm+07H4MswOVjDZPBy8cLSdhNrdnELo5AEL4JrtZWmS2eGgKYiw1+zrQ9YAIPYT9l3CmDpGMhVMO1knJ9FqOZywG8rFIU/BbGXgt/UYOqyY9bBIuqkV1zELibIjvFqx7dLBZJa+i0JqqbNqmgzQ9DzzF9Pw/4kHFDTYBbzZlavCYlVlEDUZ0Bs0BpMcahjbgt3jKFPnsEoEkku5Pg1ITbEsnnPjFPBKyCVG+CvbQqoRnVeqwE4tKEPjdFK87HHlUBS4xNSMQkDQBk1k2CbQh8Yv7S5aeMH1llpTTTvhG0wk6BdSrcEgVwyRTBVJ/3L+VoICQuzMaUCpoCJ2dPqOHjLQkHdvwGv70azLiJRNSi9MMt7TO6oXbWHwJZVO/vwdyFvf0/9AcpGZ85IHypYDntV26x+JOwI/PKX6vQkO9njSRW2YI5QVtzl6U8ib37n4XxQxbN29m7I1Ydj59JijWvfgvpf9CL7wwTnX3YLAh2lkZljjCpsBuJfPMC34tRoxLqofmIYgoBjA9MkGd+k5BepACmh50I6TqeMYnmDG3fcv2/F5ZNqrS/Irf6pcecOOyBqpvJUPflAzIPDdHgkq0fgwEX7+2gjeqkExTTdyLR8Nr8WlYkL3ltKt9pMN5DlWtEiuwIfHcAR6/hNUD1O5ewdeMU8Wk9lLkWP3GZpmMTwN7Z9tFXLwlTVWf4aY69v1bImc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(39840400004)(136003)(38100700002)(316002)(122000001)(478600001)(71200400001)(26005)(66946007)(76116006)(7696005)(966005)(6916009)(54906003)(52536014)(38070700005)(6506007)(558084003)(2906002)(86362001)(33656002)(8676002)(5660300002)(9686003)(66476007)(55016002)(4326008)(66556008)(66446008)(8936002)(64756008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fDJhoG4MZ4rP7sPbjSMUq4K58OS4CVt+32ZiiUPdSuFFNVXCekymgF6DsexA?=
 =?us-ascii?Q?Y+JNmOE0e2Kshz8MG1RT2786Qof/BEFuhxlEjv/nze8T8zllwa3PPSMzoYir?=
 =?us-ascii?Q?FCoct647/CDunTSe2y0Zpggb7KHaaTwwgWqwbNNYCiyY+ak7VIBPabbc48dR?=
 =?us-ascii?Q?jSC7W83pESgCEHF6jZ6Z/PQmzub32oQVjYCD4ZmtG6Fpog8AKIwiVNolumvY?=
 =?us-ascii?Q?ZkM8Pcguh51HZfYsxsram58V/G40Fo0fS2hmhtYDILS2f1AFHJYW7AT5wJHf?=
 =?us-ascii?Q?6J7uNXUMuBG1cqvAO5G5gMWV1+EYMmyCAl7JO1duoRz471kblK0cpB+PmQ5l?=
 =?us-ascii?Q?3SqaBIth+XFCCBYXPFOZ1i3Y7txWFN+foUEVMg4uBqMF+TxKsojYBHp9Fumy?=
 =?us-ascii?Q?1hz47Wjh9rDOlVnhuPmmpInTtIn6dmZ19lhod1Gct2uCi08BDvlgAkGEuxqW?=
 =?us-ascii?Q?7y9f5GqkMKkgYbCdLCoMDOM/qd4FLrJazPRo49iSJQfszp9FPPFhwEtdsaur?=
 =?us-ascii?Q?Fy0S8bcE9ij7a/vTw9v/jcI5+UUFmkkF24TwhFMfO2UdEaUKzVLpl35mBVQf?=
 =?us-ascii?Q?6Du/0+Eto6rLk2ucGAVrkKkeqQNbBdiCuEA+C4iBC+GmfIuYJTA/mIziyRb7?=
 =?us-ascii?Q?Ba3SJ5Ig+L5QiUw+SzMapwLQFD6ly6d8++Q+k2zrtdYd/p602a1xvCn4kPNo?=
 =?us-ascii?Q?m0/hqD4cxNn28uh3H8Bd7lKGlM/B3mi0gUBsXV6RTR9Ih2lZ9m/D2LLt7SNx?=
 =?us-ascii?Q?paJw27d3v5MyptgMpxqe5YDQdOeRntaiK5mm6H0OkgMgfQw7/rJx//KNqo2s?=
 =?us-ascii?Q?SMtVxUovwHh7kIkd1Yj4wNeKoRk/y6VC5uNq6enqV9K1EUz88/6JDUvVF7w2?=
 =?us-ascii?Q?lLbB/BJTHbeIj6bfaYMmhQYq5g12MKpVtCaRyPEV+txLPY6pFVn5/I9wnkBz?=
 =?us-ascii?Q?Wnl5hcEPOeoSDuFbmMeAkp8azRccJarTGwkigA5EwIu1w+Ds5XgLmpUXsecr?=
 =?us-ascii?Q?EaRxg5+B8ibZ727LOuLRP6MSo/uB5NaMQ54L8NXzbRMcgESYcxPZkARBUwka?=
 =?us-ascii?Q?R2EWMKqeXNQ10S9f2nrgklxXTMWdl42DMULk7L9E4OfjP6kyPpRZqiQJu+3b?=
 =?us-ascii?Q?JxRVnDW4r+CifRcZKJClQ1j1IR3ew1xNNT89bipZp4jo0/8HOaO4ChWgK7RT?=
 =?us-ascii?Q?cxH5l1o8c1MATkggeFA7Es7adOWunfJXgCsdl0fBZV5OGxqrf5Nih20vnma/?=
 =?us-ascii?Q?2bqHnOkaNQw+ipl8+w8BOFrjE9X2wE1no2kmUHUjs64LUgoTa/AAd04D2RVa?=
 =?us-ascii?Q?n8o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15cddfa3-aef8-4c23-71f6-08d952bea47b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 18:28:20.5527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WoEd091ikfOBUo/C/baib+FLqnlvnKsJVwEwKbAdb2/bVP2WXu+ZoztmTeqqLX/xBqeYuHHkLIYzyBChhzm5vIjswvx2DeMnHznTcX/fqdenxDAk8iOH/dqnE7YWoe01
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6890
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > A test of 5.15-rc3 + a revert tested clean.
> >
> > Jason, do you need a patch to revert or should I send one.
>=20
> Please, I would like to hear from Haakon as well
>=20
The revert is https://lore.kernel.org/linux-rdma/1627583182-81330-1-git-sen=
d-email-mike.marciniszyn@cornelisnetworks.com/T/#u.

Mike
