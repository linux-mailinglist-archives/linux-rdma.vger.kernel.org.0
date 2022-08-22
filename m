Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA40E59C437
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 18:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbiHVQeF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 12:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbiHVQeC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 12:34:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4893E754
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 09:34:00 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MGVNxN030022;
        Mon, 22 Aug 2022 16:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+8tzG1v97exu6SmE3MeAvZAnrM+cHc67JHXDl+Bm/go=;
 b=L2Vu+f5l9daq5kJprMw74JtX1RoJSu/Tlr7g0SbLdGhVQievZo68ML2M1xjIu3AnofFS
 BGg9zhWthS+4MwXdS+rmjw/u3V2B4aZEdmKV4eCBjaBYZF27S6TLJK0HhWwdceKDfg5m
 I+v+qUp5pp/c9dTfuRWBHHSK1Ox0WfddvUGk+NJzGEctZECljrArznrjIlg2rxfGkXkI
 8ZuOhnBcxa2bBTZsQzUD/T7f1cDEtVrFtdnVtismZZjo0T1G8nJRuVVy1pys+VeS8yiX
 +5Hd1pTTxoYAcJfunvIA4LtWxGb5BIG4BJ4N6wkNoJKGZUdagUCgw+IE9MhcupmHG/e5 kA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4csrr4ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 16:33:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27MGHDQO005113;
        Mon, 22 Aug 2022 16:33:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mn3x0s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 16:33:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYC9zMEcbZ3A+RcUxmiPTVSl15zm3ZXHZUhTb8LAHSRiNW5nVrC+unzHrGRncPi0MpctIggoTOxOWGh/P9K2OV6u0huZz3qEL7r5frhfvSoKuJvffV3D04OLuarI/+SWG29nEUldHID3e88MfXAiRs3OYO7nJbKSJhB3+AI0eHijSRcsiIbHQeaJjhLHAv71pgZZ2tySkBqjYkuXvxEBUbC9tY0HNh6rjV6gs1ceXJEkb5feG0XO1bSqx3/+JUbHagila/WYI3VFahQ1HKdI1bZjJDGDyjzq0YwfumwDqlQqRuxwetoiWbEm25+K7W3trdB33jP0rnK6bvFDjPsAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8tzG1v97exu6SmE3MeAvZAnrM+cHc67JHXDl+Bm/go=;
 b=b7r7kCuT5zby+9dD9HNeLKsja1JZ+yLhKhhg0KEwJJB3TfdEv0PTc4xQBMxnh73qwQB6JuXH0YA9dPrNJfRuQYU7oZxO0REjNvQAuumDIdA+QIh4rQhfbx2ysZg+3xyOhI7CP5q6RviUBT7zj3lWEmugc9LkvyA2OnxG1TNDLiKXydszY4Cn5gCjC44VRmIc6g01uzlnuIfl1GYTvtDBBm1DQcLajqorGsiQmD/szKq1/KcTBQbDFLfygp2ENdkc60eCPABirXHPOD/+qKz7ko2LJLWXTlGMcgXgwrqsy/hJg386NO8uyOUWmZGJcf9JevV8X28OFYkUCcrNuqD80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8tzG1v97exu6SmE3MeAvZAnrM+cHc67JHXDl+Bm/go=;
 b=WgCHuzkG4AIkJuo8xJWxkYN5zfNS33E+m3u7R39X5hMea795ACHFVjN/yBp13gxEYpUSkeU/tach+anS3JqpzMzWw1h8BvCaQ+lX/NKwAYwhjARiPz4Zm5cXU2CTAmCOXtLVxI+KMLUfFrjJzGzvjFLVUn4lsnQBGBpVqBZK2hY=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by MN2PR10MB3661.namprd10.prod.outlook.com (2603:10b6:208:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 16:33:53 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::1c9e:630c:a63f:fdf]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::1c9e:630c:a63f:fdf%4]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 16:33:51 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
CC:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rxe: No need to check IPV6 in rxe_find_route
Thread-Topic: [PATCH] RDMA/rxe: No need to check IPV6 in rxe_find_route
Thread-Index: AQHYthnN6YKlsWX32kmVE2sNoDzJ7q27HayA
Date:   Mon, 22 Aug 2022 16:33:51 +0000
Message-ID: <6E8EBFAA-E346-413E-9DEC-84EC779CBAB6@oracle.com>
References: <20220822112355.17635-1-guoqing.jiang@linux.dev>
In-Reply-To: <20220822112355.17635-1-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.0.8.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11bbda07-92b9-403e-d394-08da845c1908
x-ms-traffictypediagnostic: MN2PR10MB3661:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EtuLEzceS04ETOnQr/oxc1UvUYuvqnt2DHYA7XOfLH9saTll+iZXZ5DSgTstq27Ocr+jqwD3zpYIMXFFOfFWA5Y/Rgdm11br+/aCuxfUpQTUUzMZBLKOq7gB6gphlP7D7PrdnQse7KKsj756q2QHLVJv+Fe/V2NJm96bKXzDgQycL91pAm2zHeB11E9MxpvEI4CgS8L29cjKymF0Wl/ZTYek+YxRaanptMmuyDF+NcybEhi2o6iDQ9fAu9dhP1zozuJ9rtBGX6VZhWOCalDt9D2sJoOMD16/cZ5zVkf/OmrXg2/gKWt/ewGcXTZ6gJLpK6R8cxiMmpYqHJC1Ex9Kpoew+zLg2pPn4Nwfs1wFOu9ztDVa8k6i6643dWkIZhhfjxipAqGRkAJImLabBE+HQLXgHywXZ1nCKgaBI1n1JpaYdkhrAxCA2noFUud6mHvwVfD0+9GhcU+polzAx0l5I2z/c5yk5DSKMSTpGl0jlmxTo8rN6NuYfMCLFki/ov5iRFjZxY62LFb1Jto3MytjuzGcZ0uxiy8mSi0p5HZ5rB/5o54leIUD5FH35EZMjrT1hkfEbeE8+hbTfxFBccyuEgqql7899ALszp/6gmiXFYhH6aZpY2/qSC6vRiY6GqF9oK/L7d2YhEw4Z66pVBY1Pi5g8hrh6w5p8VEi+LDSQ3lnJCYsi0q8UX5S5SAEpjwqLVL9+ezA66FG8EcpNuanQiYcoUQdg/WOD8KctJrbGiGxZhwpR53SBF84FgiNQ95uPK4hCkdxszQg7ZG4nUoLm1oUWfkv773FWE0ynYO/1Tw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(396003)(39860400002)(366004)(136003)(86362001)(38070700005)(122000001)(38100700002)(91956017)(76116006)(66946007)(66556008)(316002)(66476007)(54906003)(6916009)(66446008)(64756008)(8936002)(2906002)(5660300002)(44832011)(8676002)(4326008)(2616005)(6512007)(83380400001)(186003)(6486002)(71200400001)(478600001)(53546011)(6506007)(41300700001)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LJ9jd2eZOw8YW6CInr/mBTN/xuElgeEZuGKKCkKaw2igrDneuN/Ut7gOnK5Z?=
 =?us-ascii?Q?q/fl70yR2+QmFbPkIDOSp9dVH2TOQMS7ucQHRyVLLQVNURMtWbRPBiHgXHWa?=
 =?us-ascii?Q?O6S4zBNk/wWmJgnP87C6yOTG1KuMG/AzJWztoO7xcwjE5BX+Tsm1rlULC5yM?=
 =?us-ascii?Q?gQiIfiQsENW+hbitqQvXIfXhKJp5CH8sT2rhLRT4aJbM5MtYwl703ES37czk?=
 =?us-ascii?Q?2QnttgdwNYURlTihIB6Hraanpi1R1/qRCoHZ+Ytar8zMU+o90AusbpVKzy18?=
 =?us-ascii?Q?pBwO3f+gBizU4R1tGZG4GqQgp/DCFPVG4UkKgq+y4S3i1jToNjAKSD1Ie9gC?=
 =?us-ascii?Q?TLbRLSHGG2NJSCdN8ZhAdWh3AmaxQVYjXp2ZualcOlGx12U2W6DXO6oGR/n+?=
 =?us-ascii?Q?7acoT8tlLXMdB8xcuClFPncoPp8nU3r8Wx2tHNGCTFAXYT4DodBbbBLEjGtK?=
 =?us-ascii?Q?M7s+AwJZOHGXbCsQ3q5tJrr1xHwFM5y6xY139iGv62Q3R657QlfKmbJtZP3p?=
 =?us-ascii?Q?+brwoHys5au4HiiWcLTBeHLWa5gcstcsebV/mtoVpi+BF4HLMZnlVJXxvqO7?=
 =?us-ascii?Q?AoyqqvXRRio1FvaYV9yLmowzbb6sN8xoWMJME8TIdkjcyNaDBlawO2Ljn83Z?=
 =?us-ascii?Q?18yNkw4ixmlF2xTIXYPsh2yJcqudZmlRjZ0tvYel23ox52dhF4GbMdGTURl7?=
 =?us-ascii?Q?883w/LTL6gyTOC1TLt7QqTjbBugunlqN72gEQovhuai0n4S4D1+EKHpnNs/+?=
 =?us-ascii?Q?mb8kKTl5lRdAt+h1hiWWY2rPonMUbSPofqsSWIkf7LFGXWasfSZolvnUruVy?=
 =?us-ascii?Q?U6xb1BXhW1/8ntVOtiKuvQxp8nb/L5OlgyZqarm+ohFWH6iPbrwUqgZokxvk?=
 =?us-ascii?Q?vlu3M0BHvoxqNJI/bwQBQ8GdJHqSpYVaZ+KAiCW1PPyo1T7KtTL3OWH+lDm3?=
 =?us-ascii?Q?mLz7qhhl2wjX/oe2UipyPs+gx9pIty6IA+orBT6Qgyxh6BGMz1Fwf+UkgYt8?=
 =?us-ascii?Q?3dafxL3i91vxgxbzyBPqj9uHaan05wIgJ6RWN+pGKolsrOxV/8BWlZyqruFs?=
 =?us-ascii?Q?I0Hzsj178K8tjuW0ur5JW6cb+KhmWNbW4fyrCg1ACvziL8pgPJ9kDdQzego5?=
 =?us-ascii?Q?RnASnlkp9nPqnvhFU+JV+T3UK1lq2vByGd5z/YhNHt4mtIIaPuXcxYZOV4CF?=
 =?us-ascii?Q?DEWasro7WpERzSicw+XQ1I1A3g3ttrJI2EFwiEM4GGTYhUvJiAtoz1mdE21a?=
 =?us-ascii?Q?QzfXeU3CUPzS4ObQa0PrSbmrLNjJjVlDUbeVXur/eKoljGddLgkG6hIpu/Tl?=
 =?us-ascii?Q?zx1YJ9ViMgeO4i2UTqZo5vc36ZrV1j222Nkbquhk6abAiHELpcyqFQFBBX63?=
 =?us-ascii?Q?T+EYbb2IkiS6RGDwv8vulxBwZElI8jECxMEpEGp0csrXF97heYuBy4McxnKb?=
 =?us-ascii?Q?ehUO8Ez1uncHR5WqGPOeH2CKJgR9KhXToZnjFQR97/OCn4xmpnC2OMgonVUt?=
 =?us-ascii?Q?6J1wcyuxALUnDJ62xsOSkjUervOWXjjnuzY9KRshLdALau35QKfk9F+EWkOa?=
 =?us-ascii?Q?VZx+GKHnggBnWzmZn9tCCVIMqq8jWWy4307tPniaF7uU41mVRObaY6tX4ShW?=
 =?us-ascii?Q?I2R2uRWg9LdesirGmj2QIvFAzctVjaf/6Nnb3+k1VqHnQsO41Oc0tevq5fY4?=
 =?us-ascii?Q?ao5tDQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0DFFDB650CB332499EAEDE6A14AE019B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bbda07-92b9-403e-d394-08da845c1908
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 16:33:51.7900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2hy/JwMoGmcMapVD9UxFuB0EQ0jC9qTmDBETG59iCcf2bue4JcyWrgkU5fWm8MwMF/kBuL3SIvZT2qTiiapMBtduhx05gSW6SgE2vvscFoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_10,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220071
X-Proofpoint-ORIG-GUID: aUQnPTOPji5bp1V_b8uXd7PpKF9HQZ6l
X-Proofpoint-GUID: aUQnPTOPji5bp1V_b8uXd7PpKF9HQZ6l
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Rather than remove the #if guard here, shouldn't it instead be expanded
to cover the entire

    else if (av->network_type =3D=3D RXE_NETWORK_TYPE_IPV6) {

clause?

There is no need to check for RXE_NETWORK_TYPE_IPV6, make assignments
to the stack-allocated pointers or call rxe_find_route6() unless
CONFIG_IPV6 is true.

In fact, if CONFIG_IPV6 is false, as rxe_find_route6 would also return
NULL, the else clause to the RXE_NETWORK_TYPE_IPV4 check could instead
become a simple

    return NULL;

> On Aug 22, 2022, at 5:23 AM, Guoqing Jiang <guoqing.jiang@linux.dev> wrot=
e:
>=20
> This check is unnecessary since rxe_find_route6 returns NULL if
> CONFIG_IPV6 is disabled.
>=20
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
> drivers/infiniband/sw/rxe/rxe_net.c | 2 --
> 1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/=
rxe/rxe_net.c
> index c53f4529f098..b0f31f849144 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -113,11 +113,9 @@ static struct dst_entry *rxe_find_route(struct net_d=
evice *ndev,
> saddr6 =3D &av->sgid_addr._sockaddr_in6.sin6_addr;
> daddr6 =3D &av->dgid_addr._sockaddr_in6.sin6_addr;
> dst =3D rxe_find_route6(ndev, saddr6, daddr6);
> -#if IS_ENABLED(CONFIG_IPV6)
> if (dst)
> qp->dst_cookie =3D
> rt6_get_cookie((struct rt6_info *)dst);
> -#endif
> }
>=20
> if (dst && (qp_type(qp) =3D=3D IB_QPT_RC)) {
> --=20
> 2.31.1
>=20

