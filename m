Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD3C3D83BA
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jul 2021 01:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhG0XKf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 19:10:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43378 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232198AbhG0XKf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 19:10:35 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RN0gB5020810;
        Tue, 27 Jul 2021 23:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wagBlfBAWsxDDzYhPVN7+5B+imRA1HNSNWiL4y39r5A=;
 b=1E78BSyCr2MKP5u1/pixQsHdEX3U7WGtd5cPqogTDHVGvApUjGiXjgeeAq/HYshDgQ9F
 r0+HmHPAaJ0cioufePkOgXiMKUJD93JwT7tAvZ4t2UccWJxtJ72Iq/hjnMNc6eZxx3xA
 UQS7WEx04fnfqeFp2ntH17zJeSdfbxn0SYpFYz5YeffIddg5aUS2NbSQZT2B3GYKsszK
 XhPfQ2bZ0iLyfWEfNg/BEVSsscvJsf8M+hwvQ3nDEBx7eEXMLjFCDcC+0bwGcwlUvYFF
 yBAOWUzr+tw9W/xB+NFcV0B8vnW/tWueHEGkO6MtLu/gGu8zaEfxEXGXhlu4lRhAtNN/ cQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wagBlfBAWsxDDzYhPVN7+5B+imRA1HNSNWiL4y39r5A=;
 b=WfkfJpn158GVCmKYpyNNzMPMrpxCmK/+p7QDGruSvBrzOeyguS5vy3V8Cizuo73UWbWu
 j0F1qgTOYAXnygKbMG6O+Ce0BN7kLke2sMnGCT0SqQMVkY3cFf2gqNjdU92GHurgADcK
 l6P8fWBHhW2a1TACSoEx8KHWHVBXjHPnnZGW6sjwoVRmHxvsAeFWLxMhS5p9X1kEl0mq
 cgYzB8dTX5gJpqiLRkPu90oeCxCDQt97jakEJ3+TxofVxjp0AiwyHOsIYbLf4aMSkZ56
 JR9CtkXR1HWgss7lM93+2dwP3yQY5d0o+36GZRIUTdTAWYfKq1RKAlc27TabQ5fG02Me Aw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a2jkf9bnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 23:10:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16RN0o7C142436;
        Tue, 27 Jul 2021 23:10:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by userp3020.oracle.com with ESMTP id 3a234we54c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 23:10:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9dZrNo5W7WGditNAB7EazaBGb0z8C1IHcjoQ0uD+vDjptljGcwfpNxBMElK3g08vTJ+P6U0tcF7W+tsIocngk19WVO7l4QfINjozDPDM7JdEhf8fW2jwi74ctWt3+QvFRF9qGHSH6K3C5loVn7i/4b62FVXzbem9xULBR3JdRwYntQs+CkcGpmT6S4VLOZi6MVIcSD+8x1V8/Pmy9Y0pwySBoXobqpDrtNyqed9VzpiLsRK6LvDJW7YFo9+FWHpA8vtd+0zjsvhVIS0MlnDDxbCnBbFiBeWuoKilLgqyVXjStJ5DwBfWyENlZyKH+u1l7o5Eu4jV17e5hBCYVNMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wagBlfBAWsxDDzYhPVN7+5B+imRA1HNSNWiL4y39r5A=;
 b=jTYfNLIq9rwZLm95mKMhlW8vKRzXKnH9AoJuIF+P34w//TPGEpxkY00sZVdQrMLxMwKKCjvR0CcBEMTSidwC9HMMzWHluNiehiIWfoV14PqLba/n2IEdNst1TsGP4ZZOYEAGrpvc0vW5GdnJR2+z5LT2iDUykh7Lamcp8IdDuoYpqcNvyBMWUD7s9YTVqFuy2qI/ur33qJ6zDc1zXkfAIc9S+yrCYCSE/mfkZwwo8WBDObmi8oeDw7qMpsHZ9IPP3JAtKAgc/+J1cmC2ANdC3i4CP03dNnaIGGWVK50LvyAsaTA/7V7LorUQzYCkVPdQHP3WkDvszq2MgpdafWSyBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wagBlfBAWsxDDzYhPVN7+5B+imRA1HNSNWiL4y39r5A=;
 b=Nzo2v3FOXaTB5HjzwXyQa1XTfsab1wdP330M9SwbzlOwEOCa8Z/eBe23wui7oMSf1k7B5AK2oUZI3/9ZgrcX1d3adWkF1M06sVvTtJ2kJuxywiMJ9U9JX7DbNgz5X1GXul1pno9bU4QGKEH9mH0knKQBlgPjWYUOxfZaufI3pNQ=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3110.namprd10.prod.outlook.com (2603:10b6:a03:152::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 27 Jul
 2021 23:10:25 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::9dee:998a:9134:5fcb%3]) with mapi id 15.20.4373.018; Tue, 27 Jul 2021
 23:10:25 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: NFS RDMA test failure as of 5.14-rc1
Thread-Topic: NFS RDMA test failure as of 5.14-rc1
Thread-Index: AdeC6xneRTsXNTlrTWuqxyNIUrjEqgAHw3HQAACUb4AAAE5b4AAAJPuAAAA+IwAABkXSIAAFD3AA
Date:   Tue, 27 Jul 2021 23:10:25 +0000
Message-ID: <9D442FCF-D0F8-40F1-9AA1-B85BAE91631A@oracle.com>
References: <CH0PR01MB7153D5381BBC3D1D0F146E8AF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CH0PR01MB7153166CD64AE0097B72608CF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CA7DAB52-ED96-4B47-A49D-88C3B8C6F052@oracle.com>
 <CH0PR01MB7153DE8406A68B049FC81EB6F2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <20210727173857.GI1721383@nvidia.com>
 <29236B57-4AEA-4DEA-AC6F-4402FF8A1A83@oracle.com>
 <CH0PR01MB7153BED95409DC4C26CC5A4FF2E99@CH0PR01MB7153.prod.exchangelabs.com>
In-Reply-To: <CH0PR01MB7153BED95409DC4C26CC5A4FF2E99@CH0PR01MB7153.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b437c311-3e8c-4115-0e74-08d95153b779
x-ms-traffictypediagnostic: BYAPR10MB3110:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR10MB311010FFF6011408DDF3D63993E99@BYAPR10MB3110.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qIWsMuiVaR4VtMcXTNT1fY9GToM58xOOkMEO2b9vOgbWSP28FSDZbU9tUd1rVkOrlsqirndrAjWBTLe4lRvB17wGghVZm1w44Ias0UC4jeQ4CMg4Tt5Vdm0D9eZZYw3icepbQ3tF90rA/GDbqtmkuk64XDKr63fVWJGhleIaJ8wTEXiWmKujt07qZ6FzFliy/1/DMPy3pZoDxEpR3yDieZwx2tIFHhiNNQG1HjLSkct/8M0pHW9aAROEZhbfwHyTBQ4OBGnp9Y++AtW7PWcczVEJs78mv2gagFyYTwTJHcebL6K3SkTPpeXl+LtTOCjpSE4yG1vcDZjKlmgfR8AXZtd4CIEYtzVfjW4HHBtBdDFoxAA178+jSv49mF2bBAER3XkEXGoi7sQeX8p/GlRDoxkLWDIo5cKqb560WwKUXdZF+fOvTybLz+qjqeM8gLYD04tNaP49vJA5nBl7aCdVsOYha2uCi/LQmYYfp6I0LscGZN4YRLWqZuIJPdOtI+mrC6duwK8AQInpvBqRJ8hxydaqi4vLq3d6qMSaJyax4kRDlq0T6Fh9HTS0I4yR9HClEKIi5DRHQMQfpOCEIr8Xd9sWL/kyeKs1qMdvsKLLZZC7JDX66ABY7A7XKwBdunB8TEeQYMih8FhVR2z/XhTleIx6JJGo5KEE2RFEiuV0lYhIMj0FUMg7e5D4VhAMzNHHYZojg26wleQBtW2QZ4U5qmantsuAr3X0pKGd1j+w7U7n9MWaLjdVPSAfDcqnW4ru
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(376002)(39860400002)(366004)(33656002)(478600001)(122000001)(186003)(6916009)(5660300002)(38100700002)(6486002)(54906003)(8676002)(4326008)(2616005)(71200400001)(66946007)(6512007)(86362001)(53546011)(8936002)(316002)(6506007)(64756008)(66556008)(76116006)(91956017)(66446008)(66476007)(36756003)(2906002)(26005)(4744005)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?br+pB6+Y1xENBCiIp7RR9lqzg1GBWCnEiK+cfS5gbfDpSTQBt5uMuOaZt4ih?=
 =?us-ascii?Q?pW0qkpJtQOuA69RCtDvacGxhI77QexUnmm92c94SQUqnyUPSkxWPLY1Bunx6?=
 =?us-ascii?Q?beNqjhmx/sTr/dJNgiTbMMj2rEsy3HAmcaw6zvUBc9VNw3Z2z4Z2Wneqx/4C?=
 =?us-ascii?Q?UI18k8m1PSvY608Haf5nmD1L4o+KyWajZwPwmopP31hcT3sZ3oT6uhCYR0MZ?=
 =?us-ascii?Q?aiUsilImYaMacJ1touXkGP+7gd8T9kM59ATh4LL8RBsn3CoMf4+RnEbZnhHg?=
 =?us-ascii?Q?gC+CBRwKtVkBHyrbi7BjP53PPdCDlD+ZyAsUueTfFDYLgDoazmMpmBBJcgP+?=
 =?us-ascii?Q?DfFkMqs2NRHXYsIQ/gygnRzi88Mocjcmj3mLEZtCwjAKWHBvJKVzOts587QP?=
 =?us-ascii?Q?FHDCmFZQXIIPAfTh1T40ZbwRzWhCESZITPJz94hN58v3kjNPR0xlfLj8OkVg?=
 =?us-ascii?Q?YEQiCszgL+oQGfbDXamPXiOBDtl53T2Px64oGi94A8XvJ/boZARmi6YGba24?=
 =?us-ascii?Q?5ME/Uk3HaENmEXNy51A8AD/1Oh9ewe7oY5O3nO3ShzoXmxJ2AmXBXsftmxfM?=
 =?us-ascii?Q?eIM2eCAL8fQmraKK6UOvjD2ezXcLk5jU5pp8dqOnzTUyAk05Xe5YSorXDE83?=
 =?us-ascii?Q?PTKOVbceVuWP/X5MdNvez8UJ+W5aXmYFMGmOPQInkVdJokzvEPMFhNnPrfqT?=
 =?us-ascii?Q?45iRSTbQhMhg6NdZn12HfI3faNmF3m8GxYItzgfpzyMtG87WdFNjo51jRhFV?=
 =?us-ascii?Q?g3AV1cvJMIRObykqsbiDvpIEvpRXa1XozlHs3smlhmgd71ufdyHfkGgdnih7?=
 =?us-ascii?Q?cWS7FASzyoWx+AR9PqxlBAfKMPE4SjUmAV4Vh2tioOcnFpXh0Ni9IW1ktGfp?=
 =?us-ascii?Q?fM5dtgpRa2Mx7z8yNcqUo6WoqMqqyihGuAbRWarVGfJSQ2GD8WoxxAgp+6wC?=
 =?us-ascii?Q?maF7me+GgPvmO4foJlDFru3GnRyMuPX0lvJLBhFHE1icLlV6/YwSTH7Pk2IZ?=
 =?us-ascii?Q?K0CrDnsI7mAZquG+SZ1hLziXxADUrDSqnNL4gR2fjmi6yBQfHQuXHZcG2yCV?=
 =?us-ascii?Q?mLZxY/UiIhUpZSMgzTZ7yrIPEQSoRehNQLKLZ/TuWDWWmdMOjAUiZqzaeWOi?=
 =?us-ascii?Q?wG0VTOvem8Frl67BE7lRethdWG1Cvo5QIUjDCJOg5dF6V1xuThTGK12Sf3Wp?=
 =?us-ascii?Q?CZS/qyRUSIkOKckDIW1A3bvt1sKM7nXg+puh19Y9OonVRsDkOp2FFrXQYhOq?=
 =?us-ascii?Q?WAmhayCmtkZYPJvPXqfAsR2kEggv5SG5b4raMDdbM2OZCUcfUL44tv6aTfGV?=
 =?us-ascii?Q?Ixf257cNzhmR3eW7jiHkwxLk?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2C21B95357A4D141A03590EFD096185F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b437c311-3e8c-4115-0e74-08d95153b779
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 23:10:25.0899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SkBqrwLPKFJlEz7QHv1LEmiKoyNmNGOa3s2u05k9G5XB6r7f6C9XFYMU+TgwAlrTkCll4PROSavAvR+ZI6BfFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3110
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10058 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=989 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270133
X-Proofpoint-GUID: Q_0DY5rt26aRNeu6v4CdZSVvxvQHVrLT
X-Proofpoint-ORIG-GUID: Q_0DY5rt26aRNeu6v4CdZSVvxvQHVrLT
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> On Jul 27, 2021, at 5:20 PM, Marciniszyn, Mike <mike.marciniszyn@cornelis=
networks.com> wrote:
>=20
>>> Haakon's original analysis said that this was an INIT->INIT
>>> transition, so I'm a bit confused why we lost a RESET->INIT transition
>>> in the end?
>>=20
>> Perhaps the patch should have removed the ib_modify_qp() from
>> cma_modify_qp_rtr() instead.
>=20
> I think that will work.

Implemented and tested. It doesn't work. :-)

The conclusion I draw is that there are still spots that depend
on one or the other of those state transitions remaining where
they are.

--
Chuck Lever



