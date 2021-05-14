Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DCE380A8F
	for <lists+linux-rdma@lfdr.de>; Fri, 14 May 2021 15:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbhENNoF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 May 2021 09:44:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54598 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbhENNoB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 May 2021 09:44:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EDdALo019904;
        Fri, 14 May 2021 13:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=JZmqJU4h7F/sZysKb/miALV2zWt469ImvSW4v6ZDn5g=;
 b=vBALLgQxiahPvBuR9uGPheBbEdKrGQZ1iHvmUeVvZqODv1Qo2GE7fg32oN9z/KTksPxX
 Huk2qNsnMmNILNEAGtSPkW94ocwf/cAYH2iayxWZ4yYaJfpnHl54rmtcl8MO+9Vj40n7
 MokOLuq3a8/CqKfUi45CUYV7K+7vFz5iUtxgT7XU7joQ/CToPhawCH1zX1jYLOM/HzRR
 1QxTHWodmDrNPjds3y5t25i451glnZRKdcLIoL/TU8yIrCgu416hY0Rgz+MYo6F5P77o
 wEmoNcos5lUEubmv5MGgaivc43yjQXZhb3EwJ41MsF+PDGS39inX8t68me4HsfCeXC1W Fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 38gpnumbyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 13:42:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EDdnlS048368;
        Fri, 14 May 2021 13:42:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by userp3030.oracle.com with ESMTP id 38gpq33nmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 13:42:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1LaxJWuRkn7A6ZG44zoiRHKTjXCjzpHpC36d5q0+hUFDtrIxve0IxMOwobD9zd6GFEFYsmBTKjOQYjvB5SYljvVU9AeNHjUPCIZXl0sAD4LRM5ZSG2Fp4aRCBOCrMNlrrcPaYg7URnwSopIvk5z7MUphHFqge+9j4fpS/GiOt25+NBTpXHUhR2Kn0J2+07My/UhpYALQCdgo8MEV5XD13xNnrMQ63qp/R4Zp2NiQkdA4pNB4lSxRZMz+CVgqo0sTCMSGdQRzGxCjqmt0qr2nDnp7BteuFtotLWIPkLMAC0Tb88hniGu0J7KSRsAJLSdPzVFLvNgXVrgsU50Nf41mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZmqJU4h7F/sZysKb/miALV2zWt469ImvSW4v6ZDn5g=;
 b=Lqjc4b6fXanjLCN1PC6S6Dcjv1PrKEb4wFjFrG1ZwJ3hXnM/lTXCPF1RC+eI9fQxT6FnL1AR2aQmrD268+W+HjXUi3PxCS1hPxMeYj37MBHAcuzxHkEVSepr6Ta4vXVcMyN3QvdyT3OsM6LliIDcenhIwsg5u8hFuI26YzMcJhKK3wYKOoD84HsdqHP/nUb/4/YXyfRR31SRbg08uF787IbvevSdpdUGbOpAvlbi+Nyw8c+sydbYS6Kq/1EApt6+5fuRWjObIRXGI2Jd5Afi9bGoWEqN50BetolK5vJa/6w2uv8yIZ4EXHoqq5XtBN8bIKruxk80oSKkF6v/mmKpMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZmqJU4h7F/sZysKb/miALV2zWt469ImvSW4v6ZDn5g=;
 b=qoNrwXTm+c6+UirVWMhz7TmcDCmENvOotpIq/eZiiTyYQbkDkT6lcYqfQYoPW6qcasibRzXPxSnl5EhVo7Qh0m0WPcMFQIc+uG+Ag8Q6RlMZu4ff1Dj2BkwUVNCF2CpPlll1dYROAZeUX3pX6JuHXCfjVfty3rdcuWs93WSBeCQ=
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR10MB1479.namprd10.prod.outlook.com
 (2603:10b6:903:27::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Fri, 14 May
 2021 13:42:43 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::7c49:4778:12a9:c4d]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::7c49:4778:12a9:c4d%6]) with mapi id 15.20.4087.047; Fri, 14 May 2021
 13:42:43 +0000
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>
Subject: RE: [PATCH] IB/core: Obtain subnet_prefix from cache in IB devices
Thread-Topic: [PATCH] IB/core: Obtain subnet_prefix from cache in IB devices
Thread-Index: AQHXQ0pi/HLZMpxzBUi7HBs/GgOkeKrbAJAAgAgDTnA=
Date:   Fri, 14 May 2021 13:42:42 +0000
Message-ID: <CY4PR1001MB208657D6DD29CB6A092D5C73C5509@CY4PR1001MB2086.namprd10.prod.outlook.com>
References: <20210507140638.339-1-anand.a.khoje@oracle.com>
 <YJfCkMETxfnzd5rD@unreal>
In-Reply-To: <YJfCkMETxfnzd5rD@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [103.155.226.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68f1c611-1fb7-4842-b9c6-08d916de2646
x-ms-traffictypediagnostic: CY4PR10MB1479:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR10MB1479B346A462471EAF7DAA8CC5509@CY4PR10MB1479.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JCrnXBtAVcZY/n1IfLuLB1jClrEEBYj9PIegfiUgR5kYDf1SBOunUq0gNbDbqGKVxWhaonPwaWXmqo0YUjCl3lLYBPxBcma5UzRfOBpVe4errvPbFwh7E6c87Y9adboJXF13KRbjPJsZZfGzL+G+TZXWvaW1mv5vL9q2uOE47cVBBG9WENQwgsoI1+RaTrI4Pcs7ZRH1FiWEqOut2kiF1XvHHmGWn7bd57YpEH20Jj7kCyRh/V8MVuqN2sEVLctZCzhoCdtd3iXb4oXn6F/6DVXCTyDMQjjL2gXp4A1fvBVLkMB7HcPC9uDP23iKHjkUwUnKSqmcqlD78ma6GJKJFemUCKrKh0r1WDsBxZUmsFKPbErKw1xMODFk72lpkcItNW33+2nRXArlvGQcD+802CSydHKQjZ1GQSOvyTz9MxONLd7vTumGTOdhpKqmmTXmAh5m9Yyu4ll0UUn9Pai9o/5VQfsFwxZmsdBcya+qq2vYckLh+2BMyGV8PH7MEoxVIYUXGVCQ4Ys2z9fWENwUg/b1nVpv9PXQp4R692SWxBTyYYsdi7cu3NgeZPwYA1n1zvOwhBeNFq6+yUsjkG+qnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39860400002)(396003)(346002)(5660300002)(66446008)(64756008)(8936002)(66476007)(66556008)(55016002)(33656002)(478600001)(9686003)(316002)(8676002)(66946007)(4326008)(6506007)(53546011)(7696005)(54906003)(26005)(86362001)(76116006)(6916009)(52536014)(71200400001)(186003)(122000001)(38100700002)(83380400001)(107886003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sB2Ty4Dxn2gAtAwyrzKoETvKG/cr065KkHrWVFZbeZBuZMRTEnQ+if+GmDg3?=
 =?us-ascii?Q?WJjWh8JCQMBSRPrbRjRqBjozgdJUkWSwWuLD4zm7oS/hRMTyNQ5GhT85sa+N?=
 =?us-ascii?Q?HEId+6fnR19X8YgNH0e9jwDuqczzhLWAVhT2YIfV6N7N8U7MSp/Dy+Nl/IJX?=
 =?us-ascii?Q?Sex0eIKE6ajKsOkJFqO9GlDxh1fA19t7eMPrpZkrSr9Fh3SEPz3FcQ1USz9x?=
 =?us-ascii?Q?rkmTZP4tuJTaCYWs/ox8jDHMun+rn+9D3RR8mJoBWIwI/qLSs2Us+jkD7pdc?=
 =?us-ascii?Q?LAam0Fxzyfo9lGSoaC4uxZ0VzZS/uGE3nRdgPkMDlmOWwYMXd/0WlMo4ccz1?=
 =?us-ascii?Q?4LGrgQRCZu2PJ+Rl2BlqpHa7Y+5vLWhTDeXJtqdXggRShRyvObpp3EPTF69M?=
 =?us-ascii?Q?w9zOnd5Ahf8lTB9QawC6v0fVsaXyr7DlqHpkeltAT/aLLA9cpkCZ9e2klZ7c?=
 =?us-ascii?Q?ceLfA91bA47R5hCeO2AkbnwS8AIlCptCuAPO4zqAQhrnDGzwWYUiXImfs/eU?=
 =?us-ascii?Q?aqWc0UbN4j1VxRO8qbD4wjOGaQK8RZc78RCEYKpl/7PDyq/tqKLw8ebNNw8+?=
 =?us-ascii?Q?MdoVlComrJx4oFk6YMpHwmh2siAXfV6R9H2dYOxrsi6O7V60LpQZEp80wDns?=
 =?us-ascii?Q?b34Y1s8H4MQfdHJhdwuC+PZ8qhwQm453NmpYLU+fAetdP2sab6rJOEQ1/504?=
 =?us-ascii?Q?MaJpkChBRJXhcnvO3BwGUGmjeGaO82V6kx5rEZOhVGJ3LjAwaOwg2Is9AiaI?=
 =?us-ascii?Q?9L8JuNG2CkH5t8kHeRznhyv33pse1zzYwwrP0mNoggx+Ff6SYz2aI+75e+wz?=
 =?us-ascii?Q?UqqNcTrM6yc5JtZIVAY82skSa7kamCX8sgtdE3z+SuJsK+6prDTqrQ6jdwkt?=
 =?us-ascii?Q?rd04+Mv2yGmKlQNjfkIABSTzFrzmLWIw+fJNxm7mOa4ff13jlx64xNweE69e?=
 =?us-ascii?Q?kHUR2teFYkHy23OyYSC/je2BNhKBU+Vt51IAZFl5bUXaOZQFdcpYgirTH38m?=
 =?us-ascii?Q?HNXfjHpR2Gaoi5kLPbtiL9K50bHtXpNydEtCTzWh6It2KnvwwGAHDzMFgGZW?=
 =?us-ascii?Q?NWHz6Ex1NxP9iCHcpZYLJ8KZ+Q8EhRLqqdGbln2v/i8A1fIQaDhmGJ3cVfPw?=
 =?us-ascii?Q?1N0QqMtXyfxlY3wArMIQiz1NcEFt2f7AqgftCdUkJTqZ/LuJsVokdjenxnMY?=
 =?us-ascii?Q?RhBkgPuA0l2nAizCQhC4JjzvBQw5wlQAuHX6QOCAp2ypVpu7mOuJJ43aCw2q?=
 =?us-ascii?Q?IGch4kHkNCom2nEJWg9TmGjDlP0q68BXFckUtrk3mU/xBBFma6d615jLMoEU?=
 =?us-ascii?Q?JZwiHVMaHe9K2ovNAgumLxZv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f1c611-1fb7-4842-b9c6-08d916de2646
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 13:42:42.8986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m5yTV47gPFdNv3MoJ/WIMwd3XWCnskeqyRNj4BfnXM4fWzL+m5oUWETfsMlqSQOReOaVS8h/YvVHlR+KKd5EhHi2bQYCcCHAdp/O5s9vd2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1479
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140110
X-Proofpoint-ORIG-GUID: 5t_cbLxzGMqryfXKAIE6Qm1CKnNjoh6X
X-Proofpoint-GUID: 5t_cbLxzGMqryfXKAIE6Qm1CKnNjoh6X
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140110
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon,

If I understand your comment " Can you please make ib_get_cached_subnet_pre=
fix() void and move port check to the security.c? " correctly,=20
you want the check rdma_is_port_valid() to be moved to get_pkey_and_subnet_=
prefix() and ib_security_pkey_access() before the call to ib_get_cached_pke=
y()?
If yes, do you want to move that check from inside ib_get_cached_pkey() as =
well?

Thanks,
Anand A. Khoje


-----Original Message-----
From: Leon Romanovsky <leon@kernel.org>=20
Sent: Sunday, May 9, 2021 4:38 PM
To: Anand Khoje <anand.a.khoje@oracle.com>
Cc: dledford@redhat.com; jgg@ziepe.ca; avihaih@nvidia.com; liangwenpeng@hua=
wei.com; jackm@dev.mellanox.co.il; galpress@amazon.com; kamalheib1@gmail.co=
m; mbloch@nvidia.com; lee.jones@linaro.org; maorg@mellanox.com; maxg@mellan=
ox.com; parav@nvidia.com; eli@mellanox.com; ogerlitz@mellanox.com; linux-rd=
ma@vger.kernel.org; linux-kernel@vger.kernel.org; Haakon Bugge <haakon.bugg=
e@oracle.com>
Subject: Re: [PATCH] IB/core: Obtain subnet_prefix from cache in IB devices

On Fri, May 07, 2021 at 07:36:38PM +0530, Anand Khoje wrote:
> ib_query_port() calls device->ops.query_port() to get the port=20
> attributes. The method of querying is device driver specific.
> The same function calls device->ops.query_gid() to get the GID and=20
> extract the subnet_prefix (gid_prefix).

Please add blank lines to separate paragraphs.

> The GID and subnet_prefix are stored in a cache. But they do not get=20
> read from the cache if the device is an Infiniband device. The=20
> following change takes advantage of the cached subnet_prefix.
> Testing with RDBMS has shown a significant improvement in performance=20
> with this change.

Here too

> The function ib_cache_is_initialised() is introduced because
> ib_query_port() gets called early in the stage when the cache is not=20
> built while reading port immutable property.
> In that case, the default GID still gets read from HCA for IB link=20
> layer.  The shuffling of netdev_lock in struct ib_port_data is done=20
> such that the size of struct ib_port_data remains the same after=20
> adding flags.
>=20
> Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
>=20

No blank line here.

> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/core/cache.c  |  7 ++++++- =20
> drivers/infiniband/core/device.c | 11 +++++++++++
>  include/rdma/ib_cache.h          |  7 +++++++
>  include/rdma/ib_verbs.h          | 10 +++++++++-
>  4 files changed, 33 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/cache.c=20
> b/drivers/infiniband/core/cache.c index 3b0991f..b580c26 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -1627,6 +1627,8 @@ int ib_cache_setup_one(struct ib_device *device)
>  		err =3D ib_cache_update(device, p, true);
>  		if (err)
>  			return err;
> +		set_bit(IB_PORT_CACHE_INITIALIZED,
> +			&device->port_data[p].flags);
>  	}
> =20
>  	return 0;
> @@ -1642,8 +1644,11 @@ void ib_cache_release_one(struct ib_device *device=
)
>  	 * all the device's resources when the cache could no
>  	 * longer be accessed.
>  	 */
> -	rdma_for_each_port (device, p)
> +	rdma_for_each_port (device, p) {
> +		clear_bit(IB_PORT_CACHE_INITIALIZED,
> +			  &device->port_data[p].flags);
>  		kfree(device->port_data[p].cache.pkey);
> +	}
> =20
>  	gid_table_release_one(device);
>  }
> diff --git a/drivers/infiniband/core/device.c=20
> b/drivers/infiniband/core/device.c
> index c660cef..6d62023 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2064,6 +2064,17 @@ static int __ib_query_port(struct ib_device *devic=
e,
>  	    IB_LINK_LAYER_INFINIBAND)
>  		return 0;
> =20
> +	if (!ib_cache_is_initialised(device, port_num))
> +		goto query_gid_from_device;
> +
> +	err =3D ib_get_cached_subnet_prefix(device, port_num,
> +			&port_attr->subnet_prefix);

Can you please make ib_get_cached_subnet_prefix() void and move port check =
to the security.c?

> +	if (err)
> +		goto query_gid_from_device;
> +
> +	return 0;
> +
> +query_gid_from_device:
>  	err =3D device->ops.query_gid(device, port_num, 0, &gid);
>  	if (err)
>  		return err;
> diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h index=20
> 226ae37..bebeb94 100644
> --- a/include/rdma/ib_cache.h
> +++ b/include/rdma/ib_cache.h
> @@ -114,4 +114,11 @@ ssize_t rdma_query_gid_table(struct ib_device *devic=
e,
>  			     struct ib_uverbs_gid_entry *entries,
>  			     size_t max_entries);
> =20
> +static inline bool ib_cache_is_initialised(struct ib_device *device,
> +					   u8 port_num)
> +{
> +	return test_bit(IB_PORT_CACHE_INITIALIZED,
> +			&device->port_data[port_num].flags);
> +}
> +
>  #endif /* _IB_CACHE_H */
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h index=20
> 7e2f369..ad2a55e 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2169,17 +2169,25 @@ struct ib_port_immutable {
>  	u32                           max_mad_size;
>  };
> =20
> +enum ib_port_data_flags {
> +	IB_PORT_CACHE_INITIALIZED =3D 1 << 0,
> +};
> +
>  struct ib_port_data {
>  	struct ib_device *ib_dev;
> =20
>  	struct ib_port_immutable immutable;
> =20
>  	spinlock_t pkey_list_lock;
> +
> +	spinlock_t netdev_lock;

This change is unrelated.

> +
> +	unsigned long flags;
> +
>  	struct list_head pkey_list;
> =20
>  	struct ib_port_cache cache;
> =20
> -	spinlock_t netdev_lock;
>  	struct net_device __rcu *netdev;
>  	struct hlist_node ndev_hash_link;
>  	struct rdma_port_counter port_counter;
> --
> 1.8.3.1
>=20
