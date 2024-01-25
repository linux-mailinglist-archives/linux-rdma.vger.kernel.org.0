Return-Path: <linux-rdma+bounces-758-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5C083C9F5
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 18:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BE82861E0
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 17:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B1512FF8A;
	Thu, 25 Jan 2024 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PFVUX+FM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE25A6EB56
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jan 2024 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203686; cv=fail; b=L6k4xx8XwUeNm8Sc1/7A78CVSgZhYsjQqbDPeXjvqJDFKGtotnXYS7blJd6691QyG2Z6YLZP7K57mAaqs5DS3Tw0jZJ95YYskXGpf00bfsxervgbql5XPKqgM/dXzSmlG/hHmoOzulrnT3Fs+OyAsrCWAD+wd+/JxErNUw7Fr7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203686; c=relaxed/simple;
	bh=yV6j6/hkC+dJ34Nb1rmhC+DDLqA+kziVmJxdzS1e+qk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fjZmkhBdzVHGF7DbbRTlbW4ghmUxurSxyJ5ja9P+G4KUwyVlYwRCD3d4XhlVHUZZb9DM3c6EepY7IONBnyxYlSs/Dsf6lfVTZl9hRy6fKXTKMSxOhTUxVBzKtrTNYVvHilUwRysK5yRTu5hI5U8dDigP/gs54TsMUyh9k98V9a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PFVUX+FM; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PGLKqO018014;
	Thu, 25 Jan 2024 17:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=yV6j6/hkC+dJ34Nb1rmhC+DDLqA+kziVmJxdzS1e+qk=;
 b=PFVUX+FM2i7bBPHS+PoQbLS6/5ip94cJz0SlyI9XObck2N5g15wT4IjE+eVJaA8GyvpS
 /w+cODALgXUf6AmtfzHr5W1roaUWgi1n5XKdDA+chXPQD/iNfw1uvdVaPZu3pAnfxjvG
 lUcpGih9s22EkBr/usFIoHKpPAY4qXwDz9qSGE+7plArky+iJDjEGWEx3C0eZwF0SSnF
 Bx8DI4Lb/9nYYFEHyNwE7GzcetsTagCWudGqwsFfTxsdF4OMJB73XVQXxWNaAKap3YgZ
 U6kicZPYhglxutPfqtem8wywOUdIMxnHOyKWdjt1nX16YA8YSiYEQoRuM++NOiplrjgm oA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vur3yfs6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 17:27:55 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40PHOjNp010295;
	Thu, 25 Jan 2024 17:27:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vur3yfs65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 17:27:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHiuPyuFUyYLDZUE+5VSrV84C4Rfm/QHBnvDF+FfL8MmucyY6I9rL/yG2MFWT3nRlncJlZNbeoPJpaQMljprnPodDewgoR1abpUpwUzqBnCKMQ8rK2aCiNqAIDSu7bkn2uqVM0QWktdWlTe/6p2SxeZnLq9VO0OkxBov6VKqlWAcoa8WYLcVO0QE3iQ1AoMMuF/u0uTl0EJa99JXAODuRfDenBBNuUQWJdZkIn509uSpKqd8i2+ZfDOU6pv1lbQvF0n/nQD4tX1rp3mp9eKRTlP1nskRnS3GZk/SIZ3hCKWeNNRT3COf+L2LR0lbrmkAflL8a/OW/KhxJd7pqSpBhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yV6j6/hkC+dJ34Nb1rmhC+DDLqA+kziVmJxdzS1e+qk=;
 b=ONaOufFxemc8Wd9pBF5svIXNexVmUVbhrjg2QPittbAGOZ0wAcpI+TN/6Zl9xEZeHnS9maWs5z2a6L68sjt+MMiD49JIg2ol+nBt76lsNDMVIO/7iLyhKi0OIGwBJdlc9LY4R5QZUZANWqhxynaNIX6td/hKi7ecu20aF0kqGdndt9sbCE+RPKImjf6vlHl7KigH+bwNZ4o5MfACflJYO0i5q7iwJEauBdNBmg8XXJv8mlOWkSD2Jra7rbkW7YrxmbNzmH0kXXyw3ClkPQ0PvJgG25QimCj9szhgR6+Aulm8gs4j82yK/KtB+dDy/ewWlSZ2fWAt7aK8FT5gJoyYag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BY5PR15MB3602.namprd15.prod.outlook.com (2603:10b6:a03:1f8::31)
 by SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 17:27:53 +0000
Received: from BY5PR15MB3602.namprd15.prod.outlook.com
 ([fe80::ef43:b039:d814:a96]) by BY5PR15MB3602.namprd15.prod.outlook.com
 ([fe80::ef43:b039:d814:a96%4]) with mapi id 15.20.7228.027; Thu, 25 Jan 2024
 17:27:53 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Guoqing Jiang <guoqing.jiang@linux.dev>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>
Subject: RE:  Re: [PATCH] RDMA/siw: Trim size of page array to max size needed
Thread-Topic: Re: [PATCH] RDMA/siw: Trim size of page array to max size
 needed
Thread-Index: AQHaT7PTGr04AoxfyU6fsYfwv2FaKA==
Date: Thu, 25 Jan 2024 17:27:52 +0000
Message-ID: 
 <BY5PR15MB36028A78D66BBEE55A54C67E997A2@BY5PR15MB3602.namprd15.prod.outlook.com>
References: <20240119130532.57146-1-bmt@zurich.ibm.com>
 <05415e8a-2878-04a7-efeb-4119b95b8fd2@linux.dev>
 <BY5PR15MB3602E55D5186E1A241489C8B997B2@BY5PR15MB3602.namprd15.prod.outlook.com>
 <a4496a1e-c7bb-eba3-1095-07b4472786dc@linux.dev>
In-Reply-To: <a4496a1e-c7bb-eba3-1095-07b4472786dc@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3602:EE_|SJ0PR15MB5821:EE_
x-ms-office365-filtering-correlation-id: 0bf3c793-7b2c-42b1-3c07-08dc1dcaf61a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 XAUhIA2fSjeL5ZMv9sAUEezlwdjdALwoYn466PXSrjVkAViO70S268Rc1YSz4jTT6TgliD91DvQW4NYkQoFc9mQ9qe7GVVHTvNT5DCHIduihudAwP1Fi+tqKLF6fuBANMjjCTc6aiNXCnFHprb7D/oXzpHMy+NZ2BQO3lMlhZvWe9AGh66jHDNpsKwaKYQ0ZG/P3Cum/lC2Mgqx9kR12dFMFZuXhb4ki7OV17gMjzE3B5BKOG+m7c6h8e2AubVSj5Q2S9edPIFJZFdu36R1QTFsL0yMC0nzzEOHUlOQEl31JAX8E3kx3LzK3M1DuuVCOJH3PvcoH2NNglimPeiOMgdB1wD1VCmm81/w5SNxp+sgfY+54E60bPY8f7y6FehNMU7403CXxMvmEn5DmlkJf9fzDD4gzmwFeJh/GywwZ4waiOez0cqAGJY3Ru/2nbtgQxwXt1tOI38bqk/SVjUAwygLvm6qI6Rzy06reQFw72Xe9aHpn/mgfptPe9Nvk6vRF7gaymIppxve0uuRrFloYwA1ry+6TAiJapEGgSC/15Hck6VUHQM1J7qi9nRdyAJe4FGjjUA7Nbszb4ZbGZswzfPfp1hqGh6N++28P4iKXDfLy6ifXkqXRqiHPcGBlAAtOlZsjyz+x/jnJRBMC31BDxZkxbYQMEn2lUuLk6+cLSY4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3602.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39860400002)(230922051799003)(230173577357003)(230273577357003)(451199024)(64100799003)(1800799012)(186009)(2906002)(5660300002)(38100700002)(86362001)(478600001)(41300700001)(38070700009)(33656002)(6506007)(53546011)(83380400001)(71200400001)(7696005)(26005)(9686003)(122000001)(316002)(110136005)(8676002)(8936002)(4326008)(52536014)(66476007)(64756008)(66446008)(54906003)(66556008)(66946007)(76116006)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?czZkOGlMSDZna2pMbDdPUGJOMTVXb2FEZkRHbk5POUN6eDlCZ3oyT0tvK1d2?=
 =?utf-8?B?WmszcVI1M01haXhHZlFlUSsvWXpyUnYzZnNjK0w2ZzZCOGtTVTFHSmFWb3Av?=
 =?utf-8?B?VkVpOEZUUDdKTUxJYVcyeStlNW1laUhRWXJtVUdsY2c2aFJQcktFQ0tXbUs1?=
 =?utf-8?B?d2RBZEJ4WmN2UEllcXAwcmZUcTZmT0NJNUMvbUdxT1VhSjZYNjBjRjVVTzRq?=
 =?utf-8?B?WVFuWk5XMkVkUDJHWkVDOWkyWnhLWEhOV1pidjl6aEcwVHU0SGt2K09SQkYx?=
 =?utf-8?B?MkNSYlFLWFZ6ekRrc3J1NlphcVMrd0NSK0VQeDRMdTdWWFB4c1QzNlMwais4?=
 =?utf-8?B?UnFDdXVrSDg3QzJ4ZnBlZFp4OTV6dDFObXlNMS9IdlhBazZyWG1uenN4WlQ4?=
 =?utf-8?B?QzdPTkczNC9QcmI0eTZEV1RWNVNpUlhXS0xEZFk1TUw5OGpMQlJIUlVXb1NB?=
 =?utf-8?B?NE9VN2R0NGJ5TVJFVFA1QVl3L2xBVUorTzNET3RjRVl1SkJ2QlVGeHdiYnVq?=
 =?utf-8?B?WVJxZVMzK2duRnNSUnVNS2x0MGU5YlgwZnJScUkya1R2MkM4K3RKdUN0WUhT?=
 =?utf-8?B?M0ZyRUFZRUNkdHloRmFHeGpvSWh4dTdPNks3bFB5ZXhVSkh6QlB2MStqcVhD?=
 =?utf-8?B?MitBYVNPOXlDcWtuNnlUcTJUa2lSQmV4YmorWDl5Y1NyN1hhRFJlYjhSV3Ji?=
 =?utf-8?B?d1JjUHRGVm12bnhDalJzZmFNK3ZYcFRwVXI5VFNjYm1CMkpKOFg4dEdUemgv?=
 =?utf-8?B?RllPNlduKzhtN1NjWTA4OEdjS3VRY0ZhMDJmSTBqYk01NWgrckt2ZDZjaEM3?=
 =?utf-8?B?TC96ZnVhbndFRzl6NnZYY0g3Ri9QZktuYkQ3anIrZW1kVEQrL1dRaVdIWEll?=
 =?utf-8?B?Q3R0QmdPZXBldDE1R3ZGZnNIMkRpNU44UnAwTnRMVlpPZ2RVK2RpUjh2aERx?=
 =?utf-8?B?ZkFXbFJkb1Nlc0gwa0dLR3pxU29PMlNXWGQ1MjBSbHM5Z2tzSXRKWHNESjJt?=
 =?utf-8?B?QUwxK3Q3MkMyWVE5N1JKL0M0QUlFdWVUL0I4cVFCMVE4MkxpL3JBNVNCTVI4?=
 =?utf-8?B?TlZwV0QwcGVRY3pZRnJNUlppOGN1MTdQdXRETVVLQ3VUcnltd1RIR09yeG5O?=
 =?utf-8?B?bjRZQzc5RCttK0ttSTJCa3VrZ1J3WHdtZm84MGIweUt0MWtDZWxhTGg0UnAz?=
 =?utf-8?B?UmxrUmZ2Y3BWWmUvTGN0SmllMTc2VFk4QUFmaXpUMTVGVzY2TWNNNEk1RmI2?=
 =?utf-8?B?dGNwdHc1d2RHUzZOd0NWd1VmcC92VkdXUXJhMWVTK1NmZXZpQjgrWjZERzFW?=
 =?utf-8?B?NVBjcHh3NHdYeWYxUmJsc3V3VVl6Nk5hdXc4MTExbU4wUDc2RGMvaDhKY0Qr?=
 =?utf-8?B?cGF4d01BUTVpYXM4UStuN1I1OVl0azhSeGIwQXpST09NKy9zWXZnK1FpdHhP?=
 =?utf-8?B?VWJBL0dpczRJZzcyU1hPTEh4Y1hCL3VwclZKYkhMTmh5OE9PVFlJYkdyN0l2?=
 =?utf-8?B?Yi9GT0Z3aVBYYTJkYmZuaGV0b0I2TjlLSlg5NVRzVkRPVkNKa0tiSnVROENa?=
 =?utf-8?B?dnYrVEp6Vk0wUTl2ZEYreDNQZENXT3p4Wlk2Q0NycjEzU1lucTA1djNvZTFj?=
 =?utf-8?B?VnlUMmxqd2VkRzVNeE1qWS9wdmtRdmZXejhWWS9SYWlXb0VLQzg1U2ZMaWVE?=
 =?utf-8?B?OVg2SzYvRHpvNGxKQkRpL2VER0JRWW8zK1h1endhcThLZ3pNYWhzT0p2Y3Vo?=
 =?utf-8?B?M1VyLzh6bmd2VExTVDE2QUFONW9zNWpQd0dWMGd2cWx5YXJtNWk3QVhySllV?=
 =?utf-8?B?dkdnZm1lNVYrSW56WlFTdCtZRk9TTlJKdVhRVVFiem9FN3I5UlF2S1ZpK0Nx?=
 =?utf-8?B?dnMxa1ZwNzN6RXBScGY4VkNCQ0tXNU5lOW9RL2ZhOWpWTU5GTERsaUhCWlNp?=
 =?utf-8?B?NDd2RmU0ZzRPSDFmaXVZSUJodSs0VzkzVjhYc3JjM2lQd0p6ZEh3NXVJWXZV?=
 =?utf-8?B?VkRjY0RTMkhha1Qvc3NUWUxydHh4K0xvR0pyV05GaDVTd0NJdWMvWGR1VDZI?=
 =?utf-8?B?U3FSZ1RRNXpSUHNCZ1FOM1JJdGJ1UTZ1bmdJM25ZZ0dLNHBzK3JXYXVtWmZ4?=
 =?utf-8?Q?4aWFrTjP1ORJXwFJu/ygIo93Q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3602.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf3c793-7b2c-42b1-3c07-08dc1dcaf61a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 17:27:52.8846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d2kLQRPeLPTQmUrZJoCIZ3EbKjpdg99sB86bNdf0m9lDXOvOrStZ+WIsVNJ7aqWvGkute8qg6g1LjL7NnZStrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5821
X-Proofpoint-ORIG-GUID: TQnQOhW6CKTR0DpqDCu38yh_xCey7jRY
X-Proofpoint-GUID: -_W2QJ8H02LiE8fIuboAJdVtvAA01t7G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_10,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401250125

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDI1LCAy
MDI0IDE6MTUgQU0NCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsg
bGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGpnZ0B6aWVwZS5jYTsgbGVvbkBrZXJu
ZWwub3JnOyBpb251dF9uMjAwMUB5YWhvby5jb20NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTog
W1BBVENIXSBSRE1BL3NpdzogVHJpbSBzaXplIG9mIHBhZ2UgYXJyYXkgdG8gbWF4DQo+IHNpemUg
bmVlZGVkDQo+IA0KPiBIaSBCZXJuYXJkLA0KPiANCj4gT24gMS8yNS8yNCAwMzo1OSwgQmVybmFy
ZCBNZXR6bGVyIHdyb3RlOg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBG
cm9tOiBHdW9xaW5nIEppYW5nIDxndW9xaW5nLmppYW5nQGxpbnV4LmRldj4NCj4gPj4gU2VudDog
VHVlc2RheSwgSmFudWFyeSAyMywgMjAyNCAzOjQzIEFNDQo+ID4+IFRvOiBCZXJuYXJkIE1ldHps
ZXIgPEJNVEB6dXJpY2guaWJtLmNvbT47IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQo+ID4+
IENjOiBqZ2dAemllcGUuY2E7IGxlb25Aa2VybmVsLm9yZzsgaW9udXRfbjIwMDFAeWFob28uY29t
DQo+ID4+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSF0gUkRNQS9zaXc6IFRyaW0gc2l6
ZSBvZiBwYWdlIGFycmF5IHRvDQo+IG1heA0KPiA+PiBzaXplIG5lZWRlZA0KPiA+Pg0KPiA+PiBI
aSBCZXJuYXJkLA0KPiA+Pg0KPiA+PiBPbiAxLzE5LzI0IDIxOjA1LCBCZXJuYXJkIE1ldHpsZXIg
d3JvdGU6DQo+ID4+PiBzaXcgdHJpZXMgc2VuZGluZyBhbGwgcGFydHMgb2YgYW4gaVdhcnAgd2ly
ZSBmcmFtZSBpbiBvbmUgc29ja2V0DQo+ID4+PiBzZW5kIG9wZXJhdGlvbi4gSWYgdXNlciBkYXRh
IGNhbiBiZSBzZW5kIHdpdGhvdXQgY29weSwgdXNlciBkYXRhDQo+ID4+PiBwYWdlcyBmb3Igb25l
IHdpcmUgZnJhbWUgYXJlIHJlZmVyZW5jZWQgaW4gYW4gZml4ZWQgc2l6ZSBwYWdlIGFycmF5Lg0K
PiA+Pj4gVGhlIHNpemUgb2YgdGhpcyBhcnJheSBjYW4gYmUgbWFkZSAyIGVsZW1lbnRzIHNtYWxs
ZXIsIHNpbmNlIGl0DQo+ID4+PiBkb2VzIG5vdCByZWZlcmVuY2UgaVdhcnAgaGVhZGVyIGFuZCB0
cmFpbGVyIGNyYy4gVHJpbW1pbmcNCj4gPj4+IHRoZSBwYWdlIGFycmF5IHJlZHVjZXMgdGhlIGFm
ZmVjdGVkIHNpd190eF9oZHQoKSBmdW5jdGlvbnMgZnJhbWUNCj4gPj4+IHNpemUsIHN0YXlpbmcg
YmVsb3cgMTAyNCBieXRlcy4gVGhpcyBhdm9pZHMgdGhlIGZvbGxvd2luZw0KPiA+Pj4gY29tcGls
ZS10aW1lIHdhcm5pbmc6DQo+ID4+Pg0KPiA+Pj4gICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Np
dy9zaXdfcXBfdHguYzogSW4gZnVuY3Rpb24gJ3Npd190eF9oZHQnOg0KPiA+Pj4gICAgZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYzo2Nzc6MTogd2FybmluZzogdGhlIGZyYW1l
DQo+ID4+PiAgICBzaXplIG9mIDEwNDAgYnl0ZXMgaXMgbGFyZ2VyIHRoYW4gMTAyNCBieXRlcyBb
LVdmcmFtZS1sYXJnZXItDQo+IHRoYW49XQ0KPiA+PiBJIHNhdyBzaW1pbGFyIHdhcm5pbmcgaW4g
bXkgdWJ1bnR1IDIyLjA0IFZNIHdoaWNoIGhhcyBiZWxvdyBnY2MuDQo+ID4+DQo+ID4+IHJvb3RA
YnVrOi9ob21lL2dqaWFuZy9saW51eC1taXJyb3IjIG1ha2UgTT1kcml2ZXJzL2luZmluaWJhbmQv
c3cvc2l3Lw0KPiA+PiAtajE2IFc9MQ0KPiA+PiAgIMKgIENDIFtNXcKgIGRyaXZlcnMvaW5maW5p
YmFuZC9zdy9zaXcvc2l3X3FwX3R4Lm8NCj4gPj4gZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9z
aXdfcXBfdHguYzogSW4gZnVuY3Rpb24g4oCYc2l3X3R4X2hkdOKAmToNCj4gPj4gZHJpdmVycy9p
bmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYzo2NjU6MTogd2FybmluZzogdGhlIGZyYW1lIHNp
emUNCj4gb2YNCj4gPj4gMTQ0MCBieXRlcyBpcyBsYXJnZXIgdGhhbiAxMDI0IGJ5dGVzIFstV2Zy
YW1lLWxhcmdlci10aGFuPV0NCj4gPj4gICDCoCA2NjUgfCB9DQo+ID4+ICAgwqDCoMKgwqDCoCB8
IF4NCj4gPj4NCj4gPiBXaGV3Li4gdGhhdCBpcyBxdWl0ZSBzdWJzdGFudGlhbGx5IG9mZiB0aGUg
dGFyZ2V0IQ0KPiA+IEhvdyBjb21lIGRpZmZlcmVudCBjb21waWxlcnMgbWFraW5nIHNvIG11Y2gg
b2YgYSBkaWZmZXJlbmNlLg0KPiA+IEd1b3FpbmcsIGNhbiB5b3UgY2hlY2sgaWYgdGhlIG1hY3Jv
IGNvbXB1dGluZyB0aGUgbWF4aW11bSBudW1iZXINCj4gPiBvZiBmcmFnbWVudHMgaXMgYnJva2Vu
LCBpLmUuLCBjb21wdXRlcyBkaWZmZXJlbnQgdmFsdWVzIGluDQo+ID4gdGhlIGNhc2VzIHlvdSBy
ZWZlcj8NCj4gDQo+IFNvcnJ5LCBJIHdhcyB3cm9uZyDwn5iFLg0KPiANCj4gVGhlIHdhcm5pbmcg
aXMgbm90IHJlbGV2YW50IHdpdGggY29tcGlsZXIsIGFuZCBpdCBhbHNvIGFwcGVhcnMgd2l0aCBn
Y2MtDQo+IDEzLjENCj4gYWZ0ZXIgZW5hYmxlIEtBU0FOIHdoaWNoIGlzIHVzZWQgdG8gZmluZCBv
dXQtb2YtYm91bmRzIGJ1Z3MuIEFsc28sIHRoZXJlDQo+IGFyZSBsb3RzIG9mIC1XZnJhbWUtbGFy
Z2VyLXRoYW4gd2FybmluZyBmcm9tIG90aGVyIHBsYWNlcyBhcyB3ZWxsLg0KPiANCj4gPiBUaGFu
a3MgYSBsb3QhDQo+ID4gQmVybmFyZA0KPiA+PiAjIGdjYyAtLXZlcnNpb24NCj4gPj4gZ2NjIChV
YnVudHUgMTIuMy4wLTF1YnVudHUxfjIyLjA0KSAxMi4zLjANCj4gPj4NCj4gPj4gQW5kIGl0IHN0
aWxsIGFwcGVhcnMgYWZ0ZXIgYXBwbHkgdGhpcyBwYXRjaCBvbiB0b3Agb2YgNi44LXJjMS4NCj4g
Pj4NCj4gPj4gcm9vdEBidWs6L2hvbWUvZ2ppYW5nL2xpbnV4LW1pcnJvciMgZ2l0IGFtDQo+ID4+
DQo+IC4vMjAyNDAxMTlfYm10X3JkbWFfc2l3X3RyaW1fc2l6ZV9vZl9wYWdlX2FycmF5X3RvX21h
eF9zaXplX25lZWRlZC5tYngNCj4gPj4gQXBwbHlpbmc6IFJETUEvc2l3OiBUcmltIHNpemUgb2Yg
cGFnZSBhcnJheSB0byBtYXggc2l6ZSBuZWVkZWQNCj4gPj4gcm9vdEBidWs6L2hvbWUvZ2ppYW5n
L2xpbnV4LW1pcnJvciMgbWFrZSBNPWRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvDQo+ID4+IC1q
MTYgVz0xDQo+ID4+ICAgwqAgQ0MgW01dwqAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdf
cXBfdHgubw0KPiA+PiBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jOiBJbiBm
dW5jdGlvbiDigJhzaXdfdHhfaGR04oCZOg0KPiA+PiBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3
L3Npd19xcF90eC5jOjY2ODoxOiB3YXJuaW5nOiB0aGUgZnJhbWUgc2l6ZQ0KPiBvZg0KPiA+PiAx
NDA4IGJ5dGVzIGlzIGxhcmdlciB0aGFuIDEwMjQgYnl0ZXMgWy1XZnJhbWUtbGFyZ2VyLXRoYW49
XQ0KPiA+PiAgIMKgIDY2OCB8IH0NCj4gPj4gICDCoMKgwqDCoMKgIHwgXg0KPiANCj4gVGhlIHBh
dGNoIGFjdHVhbGx5IHJlZHVjZWQgdGhlIGZyYW1lIHNpemUgZnJvbSAxNDQwIHRvIDE0MDggdGhv
dWdoIGl0IGlzDQo+IHN0aWxsIGxhcmdlciB0aGFuIDEwMjQuDQo+IA0KDQpTbyBpbiB5b3VyIG9w
aW5pb24sIGRvZXMgdGhpcyBwYXRjaCBmaXggdGhlIGlzc3VlIG9mIGhhdmluZyBhDQpmcmFtZSBz
aXplIGxhcmdlciB0aGFuIDEwMjQgYnl0ZXMgZm9yIGEgdHlwaWNhbCBidWlsZD8gSSBhbSBzdXJl
DQp3ZSBkbyBub3Qgd2FudCB0byBvcHRpbWl6ZSB0aGUgZHJpdmVyIGZvciBidWlsZGluZyB3aXRo
IEtBU0FODQpkZWJ1ZyBvcHRpb25zIGVuYWJsZWQuDQoNClRoZSBvcmlnaW5hbCBidWcgcmVwb3J0
IGNsYWltZWQgYSBmcmFtZSBzaXplIG9mIDEwNDAgYnl0ZXMgZm9yIGENCmJ1aWxkIHcvbyBLQVNB
TiwgYmVpbmcgbGFyZ2VyIHRoYW4gMTAyNCBieXRlcyBieSAxNiBieXRlcy4gSQ0KdGhpbmsgdGhp
cyBwYXRjaCBmaXhlcyB0aGUgcmVwb3J0ZWQgaXNzdWUuDQoNClRoYW5rcyBhIGxvdCwNCkJlcm5h
cmQuDQoNCg0KPiBUaGFua3MsDQo+IEd1b3FpbmcNCg0K

