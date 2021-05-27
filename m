Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4EB392F26
	for <lists+linux-rdma@lfdr.de>; Thu, 27 May 2021 15:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbhE0NKN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 May 2021 09:10:13 -0400
Received: from mail-dm3nam07on2112.outbound.protection.outlook.com ([40.107.95.112]:8883
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236375AbhE0NKN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 May 2021 09:10:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNXHtbHkEUDBHZNgkHLUsma5b7RjnoS4dEjF90Jl9PlY6HmcyYwsvHo7Wc3cCn2H0/NuY109Ls0pecTIBk3pTx6szobtNOLngVL+wbQp8gyxOkrxQqPVuaWH7wT9KA1AO4ejt6iBuVY5G6bDfwO4fBuVTyGdGuNY4m7xFB/ylPawYwmep+74vJfIuhVFZQRMMohH5Z4vFk/Oq6HKIQ0odflSCBdEzfdHReJdMoHSrn8dH5QYdgU0AKnF2b6GwWY58mUUFMvOy2sQiVTzJjqtBUePZ+VAYunmDKrs5dIRB1Ix7mgFMPMATztbvJX7XscX206bRvAmPS3UFOhGEaqvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wc5OCATF/htiX7AJhWwxgpmU94fXAoFGwAKDd2ISc9k=;
 b=Z0WzTrytj/Enm1VOwOFtueXGu82Fk+O9jwOyUm4A24Fwl/CZ++5C+rVaJ1DRYX5GqoyP/siXHlob34P78Vkdmnr0mBR9+x028F4DlhVheOvrLAeCcBSrafoQKdAd6ztV/CTIdSy1WfLUmJn+RadD3SfPrr/nb2bpZQdVKYrAp1xX/SALRCDswoETs6ZeL3WpiSEx5EMpFwU+LnJ3Cctxymka8fAZ6xuBowcXc2KzoJPBqTVPLhqyf1LXApRK3Weu6XgxubSFAlV7GKD+DclX9uBMR5E1KIA/cHR+zbVCkdX2MEGt8e9tB6vKERX+wrXREg2xX131xjh+8ugZX8/fQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wc5OCATF/htiX7AJhWwxgpmU94fXAoFGwAKDd2ISc9k=;
 b=cQXRy1bq+Myu9ui/P1r/sjv8UZzk7uYdjZLhMCjiQhPt2baCmagGJaEIK3CuyLunDnHDVBR5nQ1gK3XOxiJxMCL1SsZQOQMx8EQYn/insnvVYW9OdiBXZCJTCno4ZcZ15SgBUZ5W7EmFEDLAGOcD9syJWDvI3s9w5VEk/slZE7NqNo8oDA5WacVPz6UePK5PN28vsrz/RTrMLS2lRkNLRY+hArBH2QKNJrVdEj9DZcjgNkKu5Aemz/JMtyMXYHpMWfUgmvLDHKd9YlAUIZNycM7NeFueSGts5X9YsSRloL6H73otilQIM5B8gZcCUo6Okro3MF38EsoU935ZrQsftQ==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH0PR01MB7050.prod.exchangelabs.com (2603:10b6:610:10b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.21; Thu, 27 May 2021 13:08:38 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::7025:4451:d615:17f8]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::7025:4451:d615:17f8%5]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 13:08:38 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Weihang Li <liweihang@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
Subject: RE: [PATCH v3 for-next 13/13] RDMA/rdmavt: Use refcount_t instead of
 atomic_t on refcount of rvt_mcast
Thread-Topic: [PATCH v3 for-next 13/13] RDMA/rdmavt: Use refcount_t instead of
 atomic_t on refcount of rvt_mcast
Thread-Index: AQHXUTJ3/ws2cFQBbkS9odhLdoIqO6r3UBMg
Date:   Thu, 27 May 2021 13:08:37 +0000
Message-ID: <CH0PR01MB715336ACBA211A001E362E6BF2239@CH0PR01MB7153.prod.exchangelabs.com>
References: <1621925504-33019-1-git-send-email-liweihang@huawei.com>
 <1621925504-33019-14-git-send-email-liweihang@huawei.com>
In-Reply-To: <1621925504-33019-14-git-send-email-liweihang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-originating-ip: [70.15.25.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fe9e7ac-7393-4617-3cd4-08d921108abd
x-ms-traffictypediagnostic: CH0PR01MB7050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR01MB70507C4B32DE103A0E9BF86FF2239@CH0PR01MB7050.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xngwmdC+9I1tyrceKGe4xzHjW3FDAgiIJBVCcjgpPeXtD4o4riVJ9snurec1duAH62aKN7TZVszKRO18xhElIWVejcnfUhINTYwCaeYTKu8lb0vXA2w0rJj8CFYhuP3FxPdmat1Ua50wMI8hYy76Tx7n7iAhHktLRUFJZrYK5I81RqJC2RplU8iMwqZ08roQR+JTeVg8x/M+Zg3HjYijg6FjPz+g6QcdJ3SWqcsdmXdQboETkCLlPjtI5vJZpuKqNTWx+EcG4KtVga6uidKEIAWy9OQnYbA8LHfB/Zt4ySdAXnfIsy7dr9kHNI+RtvnkCyArSlqHf4ExrTN9LmoSAerOaKmktlUDrmYDcvtnfOwD8+CaFhS6XmvY5gcVjmJWe99TyxED4PM0QjrIc6GwDBGxNu53BXgdY+snBlehX2kJU5tKuhrl/3C/Sd0gFPR7OqzoXVsNNCUxAPqofnyqw1w/40fRojBcFmJ0193DSOWaoqheX29gF7JR91Kg8yFZ23OW4QYX2pn5owsn+OLuCubyUgfKd0SJcidZEiDuSGofBQBUHSjMsjLEJscI/MfW7iO/VNcTSfRDLqbk14vAAe4qSkNFMV3gaMLIqTTafAI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(86362001)(186003)(55016002)(508600001)(66446008)(66556008)(38100700002)(122000001)(6506007)(66946007)(66476007)(64756008)(52536014)(76116006)(7696005)(107886003)(9686003)(54906003)(2906002)(110136005)(71200400001)(8676002)(33656002)(5660300002)(26005)(8936002)(4744005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hQgL6jaC9uZie6IgUwytztrpmFPYWFHI83+krNoodVYMUhGygbiRtC9tRqpl?=
 =?us-ascii?Q?dvgjpyw+oD+wLVgn4rFn5Jzam1D1E7uNxVnn8cQyOJBfArYQjxIjizWACe8q?=
 =?us-ascii?Q?0GEDD1mYJKUkU9bLD22AoMyQwRE59uVJA6PI7MNtljAUDX52ROGf4qold11K?=
 =?us-ascii?Q?8188s88B+w+lobr8jKkcPbO5SSK0icqFCSgVTUh2dZrakDsetgf4mc1ZvIIF?=
 =?us-ascii?Q?jFuxkCLr3LbSt6ANP/rzzMz/CiT6h9pdHAo30U9a/8TS4eTtUhr+vCitbH6h?=
 =?us-ascii?Q?XOWfYs3LMz8RhV3tmSHxylCY2n4BZn5Th5JKwZ6qdgFVWUQ5XkVtrvv/iU4i?=
 =?us-ascii?Q?vjNydwDO/c1VGV/hpNm9BRqe8w5FZo/+x6NVeuNugXJaPGTPMYeZdxu4JEDX?=
 =?us-ascii?Q?4UGC7gIdZu0USZSxw8BLhJhjVFgs2ULgmmXhMvKM8bzX8qY8++yZyfmzxOEM?=
 =?us-ascii?Q?QeDWUltUPjWPCv4KuQN1RPituiqJKtVzNOey0CDJfm77g4IyeaCJGLIhRjwp?=
 =?us-ascii?Q?uGxvp/ezZJHnrqPGGult+10dvLjPMPUVyuUV5rmCVr5vL52og9kT7ee8goWH?=
 =?us-ascii?Q?VWiYrYH4FV7589bpZV5rD+JZFFlaF3JxAgqPbGi0ub6NiwMTAxFmeYESaD5Z?=
 =?us-ascii?Q?GiZteAXmoufsMTwxBXz9W0l3P7jOREQhS1+YYVW0jIn5Wv0zDsOioInPGhdL?=
 =?us-ascii?Q?ZvCz4px8e/yBBoO6fpYCPSr68jdp2xo4uv/Djy9+AjTF/DOva9yiUo9gbCBA?=
 =?us-ascii?Q?6jaaw7b1uQpbYOz+9voCKbvs5cmKsXyQIC0qUbjq9uzM03ierOFbgb+A0Ehy?=
 =?us-ascii?Q?SIq/pAzyYTODVEUqKePnbGTic0VBvBCq04Yr5Dw9JXJwWM2JUTGnOQGuUrun?=
 =?us-ascii?Q?RlWkPjsZme46qgw1ah5OIWUKyW63VyNSBcPFX+QjQhMj/zYy38H0yCEyInKP?=
 =?us-ascii?Q?Ojm2QS0k+KfZmY06UqKBEn8cVvukT8EaKSy/Y/0IhBF15dtpSOfEWQGox1TR?=
 =?us-ascii?Q?pmAdhyULxrBTa4byVtdYv6A6wFL1j8mQj3qYuhLTFqlv246S/z6zlIGNTdzg?=
 =?us-ascii?Q?LMfirbODwrWOeKqbec1DaemPu8GK9mflFTMSFY/pLJeZdIOBpjli1SlW5/IW?=
 =?us-ascii?Q?zd6WELc+x8rWnXF2fgYIK0gHDgpLUFHJODC+cK/G/Di8wnDBu/ojiZAKjVEq?=
 =?us-ascii?Q?+edyV+2WkLSwtW7lV8ubVF7Q0mKHTqMpFTSC/5ZZf9E3JeqJJXs0gnwtefVW?=
 =?us-ascii?Q?TONVKLYrGP1Ryeum8qQQNp5IHMhI8PQ70Q5Qdh1VRsBeqzbZpMqyB05LSn3C?=
 =?us-ascii?Q?aDQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe9e7ac-7393-4617-3cd4-08d921108abd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 13:08:37.9560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6L2wExqG5hnD5/M/1x4OJD9LbJzOfKSxF5aY9qHxJ/KGMb897mMCQrPbceggY4s52wh93mjbONNdDS0Hz3yPsZWfDTrE8YKb9ScLvI8WKVIpkAbidK5tkpHpAeVuuGK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7050
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> +++ b/drivers/infiniband/hw/hfi1/verbs.c
> @@ -534,7 +534,8 @@ static inline void hfi1_handle_packet(struct
> hfi1_packet *packet,
>  		 * Notify rvt_multicast_detach() if it is waiting for us
>  		 * to finish.
>  		 */
> -		if (atomic_dec_return(&mcast->refcount) <=3D 1)
> +		refcount_dec(&mcast->refcount);
> +		if (refcount_read(&mcast->refcount) <=3D 1)
>  			wake_up(&mcast->wait);

Is there refcount_ that preserves the atomic characteristics of the single =
call?

Mike
