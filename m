Return-Path: <linux-rdma+bounces-730-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAF583B2AA
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jan 2024 21:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7828CB26E8A
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jan 2024 20:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F88133414;
	Wed, 24 Jan 2024 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I1gwFfhx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C0131755
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jan 2024 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126409; cv=fail; b=H2EPzk/F0q37DS9l4F6FRLUXwkkZV7ybYifpPPrn2IJbTcot19MCThCS4l5VPa4XJM5PTcSuFhmonAZb0y/w+h6SJ96bPWWcB/aRNnWKb9M6sQ9a4iOqe77oAwoVFePcl1HC+4AGera1H2e7qfkSBcA18l+qwfDtBORE+LVd6uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126409; c=relaxed/simple;
	bh=4ucuOgY38Lpff8LtoJ11UYovi5RjCTeEIHfE1uPznII=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cAnzWLR2Pb8VCnn1x4f6vbV1hpG9qv15qBRlB6wPVTBVqm6xN+AcktFSmUi9S1hvRwVmEttWBRK1qv1YrZJy6xdeLRmgibKTP34prvM4cQfJTEDKFrxHoeGAzE+DRq14XPmqmCjAcj4WFJuMO2jEFJ6oW8C+/5rDjV9Vx2q3/Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I1gwFfhx; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OIqoJn026151;
	Wed, 24 Jan 2024 19:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=4ucuOgY38Lpff8LtoJ11UYovi5RjCTeEIHfE1uPznII=;
 b=I1gwFfhxKgytvhilrQWW/OrqfDJ+HBOeWLjVkHNNb7ot23DaQ9LfOgwdhgt0BcxIbocg
 VEmdosmF/Zu87ArZhfNuxrp3Mj1OUB5lO3NMFJ3RiQ5lGDPxTBmY5AckB5PMSS9+z6Yl
 DjRdasOHydc/7+ApbJLnbiKMgmcPjq3RE1W5t/oE0PSOYnD99ImxFrsteb59BEJuBo+R
 TAEkUJ+N9+huZdszHyFR8n/x2usPMd4d3gbyZHf9FHDQTSod/FrdbnT2YrUsFqyKs2BF
 tMknBNTJm0TvMHs4qtW0h6SNftZ5N70J5Uu11ixAS1fdGBqXB6KfmezOpr23ngzMnD7X 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu87c1wu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 19:59:52 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40OJj7qI004375;
	Wed, 24 Jan 2024 19:59:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu87c1wtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 19:59:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6tpqvx/C3xuElLY1V/UsG/UekL4VJnXemJqbFuMXxEqwuauCB1vjHOLbEz6UyKN3tg0/cSo0/5paX7KyKPZZ1MVMel+HJ7meiCHID/4nn9MQDl46D3TzH4SuuWBaoOV+VfhpeKD05T1qZTOvnQ9flNCBZEx9aPUP/pzJC32AAEiXFZO0jAhhVRwkPwBoz9ThiuhtUueGgcyhfvfOlAw2MtLDZa5YIhmNzA369K1k2UQkRmD8+Aj42xrMCnXp+JupkanNYhZD5zdkyZCYVn4BMKgIoGjzR5mvuFXdpTLJO4aUD/iyV+7gHp1W/IRJhBhrL1xlSB2i6CzJgXYykbOSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ucuOgY38Lpff8LtoJ11UYovi5RjCTeEIHfE1uPznII=;
 b=Cs2RkKVfGkpbfu0IC+D/rHNZNH7hckrRU30sEYh4F9YqMCJCcTM83y/5/DrpLadQqM5jGLZWCs+Rlxl0TvzrMWYXDxOqOtS/Y/DvZBUCmDXgAh82TUUHn943NXUOJw+xWNsGsyhPZdu/e5mnz6fWwMr/EvYNc3FwU+2wF3QXlDbvby3q6jpEiOxl+X/NVmM/O/fqKz930hwTyF06d+C8v36v+tD/dOzEUHYt3c4DQX3ETcH2NVbRMFr+FXaZCSQ3VsGvJLIqAo7rPu+mk+Wj4id6C3IBjMhPGiQTS8iDdA4Lr4Ebwz6LXgBtvm2CixJkTUoWOf7iH4wLiBD0OzKepA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BY5PR15MB3602.namprd15.prod.outlook.com (2603:10b6:a03:1f8::31)
 by SJ0PR15MB4614.namprd15.prod.outlook.com (2603:10b6:a03:37b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 19:59:50 +0000
Received: from BY5PR15MB3602.namprd15.prod.outlook.com
 ([fe80::ef43:b039:d814:a96]) by BY5PR15MB3602.namprd15.prod.outlook.com
 ([fe80::ef43:b039:d814:a96%4]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 19:59:50 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Guoqing Jiang <guoqing.jiang@linux.dev>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>
Subject: RE: Re: [PATCH] RDMA/siw: Trim size of page array to max size needed
Thread-Topic: Re: [PATCH] RDMA/siw: Trim size of page array to max size needed
Thread-Index: AQHaTv/ji/wZK3uZsEuWb1/Y7EANRw==
Date: Wed, 24 Jan 2024 19:59:50 +0000
Message-ID: 
 <BY5PR15MB3602E55D5186E1A241489C8B997B2@BY5PR15MB3602.namprd15.prod.outlook.com>
References: <20240119130532.57146-1-bmt@zurich.ibm.com>
 <05415e8a-2878-04a7-efeb-4119b95b8fd2@linux.dev>
In-Reply-To: <05415e8a-2878-04a7-efeb-4119b95b8fd2@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3602:EE_|SJ0PR15MB4614:EE_
x-ms-office365-filtering-correlation-id: 51a7d58d-b0a2-4bb2-af51-08dc1d170621
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 B/ofPQjDLccJr0Ui1fj5enzn4c+OIZeY+qBeQiMgLniiaiBgZyzz8kTbBvKX71obYnH2zLn/Z0fOP2zloQswk2Jo277G3Az2zTxv+ItOHTNe2gYnTZ8eVBuyStUIZIXQAfJgvJH+0b0Q2L5Fwb7W/c9vgrK0qIO6V9iX/hxNl6utgrCb9ptQWAJPyHYrgTHH3+k40m++T7Rp0v24eRwayf3R+9SZwERge75y1ZcwI4ZHdC4hcC9tQST97BfEu0FdY5WmhTHvGGJv6XjaRahgqRPdtT9MeBbKRVn/1IG2bjdjYLLbeGDRz7cb+FanqfT57r7erHHml/WxDFbWyZr8jvqolg//WdnJ5hDq4fcsbvpBOz85zqNRbhi44/kic09U43hpNOEhuxu/XVOLpQFQY6BeIrUDaYzUp7xqkAcUthM62sU6ydL83Aox6/0fxqIdkNpOeZEikCjlatW3rpAZBGGsiX0klhIGppzuRsgbczk7z9inqQsX8mHySTr4Lt1mrU6jABHN5/3G4Tm9KvYxsyE58vD7CfeVgzNf5kx1HsdJ95aSTDlO2PQ6MyuYyyZSnw9ULdcodWGkiu3Hd/nfHHk2QG73vvwZHtS/EZ7LC6+qjPH4RiHQzwolihndXRdokOpWC8Vc1Hl+wMUcTPCZK9w2QXXXm3i9ndG+8H3pjm0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3602.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(39860400002)(376002)(230922051799003)(230173577357003)(230273577357003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(26005)(66946007)(66476007)(122000001)(64756008)(52536014)(66446008)(76116006)(54906003)(66556008)(8676002)(41300700001)(110136005)(2906002)(316002)(5660300002)(38100700002)(6506007)(7696005)(9686003)(8936002)(4326008)(53546011)(478600001)(71200400001)(38070700009)(86362001)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VWhMSjVNQXp5WWZlYTN5Rjc3RHBVd0I0RGNVam1YazlIUW9nK3I5WVFzSWxQ?=
 =?utf-8?B?QktKcFF5bUFuc2k5MXExU2pNMlJ6Mm56eUNGYitPeWlwYnpES2dIVjFIazJw?=
 =?utf-8?B?QlJNOW51YXRJUnhDMXk2dHI0U1JYYmNBa3k4NW5aeUdIcDM3cUI5bVZXaGJz?=
 =?utf-8?B?S2ppQTBoU2x3QllHaWMvdFBoaHBIVjNzdDJWWVRBWm5peDZ4S1Y1UWtpWStE?=
 =?utf-8?B?U0hwa2QvTVF3WXJsZWN4RTdYQXkvdXZqenc1cE5UY0VtK0FTam9VS01JYWxQ?=
 =?utf-8?B?ZFVqRS9sSks2OTlQNElhZElpYWgrRDBCNnVrNTdjNVJlWURxbjduR2IwWlI5?=
 =?utf-8?B?TVUrRmF6Q2pSMmZGc0Z6OEJMR2FBcmoyOUYzSFk5L2JQd3I1SGpISUxQSnM4?=
 =?utf-8?B?QmdjclpNQS9sSHROQWtZZEMxMElBdkNRK1pwZjVqQ0NIY3NnMGFYN3ZWVmpH?=
 =?utf-8?B?ZlhRenBRS2tFcUwxNXFackI5S0pja0dEWERKbXRJVTZjK1NtcW0rTnFPTFk3?=
 =?utf-8?B?WlZXVmlTY0I1Y0wyQVF4QTNwVmo1Rkw4SS9nSTZqVFBuRWJFVTUzTE5QZ0VB?=
 =?utf-8?B?VElQZGhaNlNpSWpUM3JsV3hLREd4Q0toYTA5R3gyaXhHdS9IR0drMVBKZWFy?=
 =?utf-8?B?NitBVXl6VHRnNjZkZ1FXWHZJS3p4ZmZQNTlIRlZxa2RicFBmeWREdUV2dTVO?=
 =?utf-8?B?SE1CLzNMa2xLOEJVWHd6a0dkSG12SHhBYXBsRjZhSTI1dGJKbzVhb2hsNHQv?=
 =?utf-8?B?RHJiSk1uc1RQL3o5NDMzU2J6WDZWcnpPdmlvT0NOS2ZhWXM3WnhTZWF5eUNY?=
 =?utf-8?B?WTBkdEZYK2QwYkMyYlBaWnpaM1RiRmNZZzdDbWYyZWFxV3N4Y2dUd1ZsUDl6?=
 =?utf-8?B?ejJLVWd6cGdiUzZ6YWtSaUZkb051ODZKZ1EzVVMxcmtQYm1QSE1kSnhKd0M4?=
 =?utf-8?B?TnZQbnpISW9lZnNxVmo2cUVaY2l4K2RzL3VKb1N1YXo4QTV5WXh3SXF6QWpD?=
 =?utf-8?B?dzRhWENnU2liNkhyYTB2anlrUmVhUE9PKzRTVHBqS21TOGVvdkc0QmFhRWRi?=
 =?utf-8?B?NHB4ZHZQcUVhazg5UmpLVVplZ0NKTk5jRUh1VXd5c1NZbDIxQ2VROW1kbFd5?=
 =?utf-8?B?bmlubWtsV2lmYmphWDRwakt3VloyeE9pSXRKc3c4bDREWmRPRkUweWRNS1hV?=
 =?utf-8?B?cW1LTUJCYmxxemRGOFB0c1ljTVU1aHpwMGJCcklyYVpuRGZtYlhXTDhuMFdj?=
 =?utf-8?B?WTRoUmcvT3FxUmtDUUFFeFRObDBoZHR4Q25GemlWcXNmOTFtVFFvZnZRUWVB?=
 =?utf-8?B?VHFaTHRaRmo5UDR3MGNuQ2VsNGV0S3oyb0N3Wkk3RmtpUGl2TUVYQVk5YnJh?=
 =?utf-8?B?YXYzVlAwOVhBSXZ1NjhreVVWTEZHcW1jZWpBdWFsN3NNa0xHR3ZsekVtZVRR?=
 =?utf-8?B?R20reHhIcVptbGRjUENIdWRoVEZZTTZRTUUycCt1OGl1YnB1UHNtNCszZGxG?=
 =?utf-8?B?L1g3M2NFWmdJUlBnTTVBVmNXbmFRUGRnSVFpWmp4ZEtQaTBmVnp0ei81UitZ?=
 =?utf-8?B?bHJBTW9QUXJvNnJ0dlZ5T3ZFR0ZFZ3NBWlpkLzV0c1o4VXRqK2hUTUZVekV3?=
 =?utf-8?B?Z1NnZnpXYWNRWDl4NmI1a2xzZGJUUVN6UE80dTVGcU1GZDBmNGxScFV2UXBh?=
 =?utf-8?B?OVlzZ25aR2wwY3piSW14c2cxYlpnb0RRbUZYNWNvckJzQy9vcVY2L1lLb0lh?=
 =?utf-8?B?OCs4c0lQelNrTGhWbWlZVDNSZjEwRUsvenU3cFVRSExXeXpXYTlJOTUyeHVY?=
 =?utf-8?B?NVhQMExnbVFpeUdROEd2ZHdEQlB2Wm9SSGFVY21KUWZ4T09tVGlMd2kyVENU?=
 =?utf-8?B?NzE3TzBuUnFVSG4xSGZUcE9jRWZGWFdHMHdGbzFPc0NRTEZhcGdwek5XMStI?=
 =?utf-8?B?U3Bhc2dUeDhIL3VYQzFZcXlhYkl1VXljMjlZaGFpaEF5a1FZSWVackVNY1Zz?=
 =?utf-8?B?enl0WElUclpGeVZZMjJpeDUrQzRxeWI1RVdWNHA4UUppMTRRWkVwS1p4NE91?=
 =?utf-8?B?dnVobWtGbkx0aE5oUGdhK3RBMUtEUjlWMEs3REZYdDltcTVWK2hhc1RKeThz?=
 =?utf-8?Q?b+9DB7L95sOVnNgqzLdKom1ho?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a7d58d-b0a2-4bb2-af51-08dc1d170621
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 19:59:50.3635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpCypWz/1GiP55D1SXZbYngt0C/KqkYVXe3WpoH//JhTlbdD+n6680C2IQ5MrJmAUHNQoOn7SryGmEhTUQF61w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4614
X-Proofpoint-GUID: wrIlHto1zL59Qq5I-dM2CjfpHRF3lEDo
X-Proofpoint-ORIG-GUID: YRjRya6FPcI5nsoO1cFV2ebvI1JUHlta
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_08,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401240144

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMjMsIDIw
MjQgMzo0MyBBTQ0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+OyBs
aW51eC1yZG1hQHZnZXIua2VybmVsLm9yZw0KPiBDYzogamdnQHppZXBlLmNhOyBsZW9uQGtlcm5l
bC5vcmc7IGlvbnV0X24yMDAxQHlhaG9vLmNvbQ0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBb
UEFUQ0hdIFJETUEvc2l3OiBUcmltIHNpemUgb2YgcGFnZSBhcnJheSB0byBtYXgNCj4gc2l6ZSBu
ZWVkZWQNCj4gDQo+IEhpIEJlcm5hcmQsDQo+IA0KPiBPbiAxLzE5LzI0IDIxOjA1LCBCZXJuYXJk
IE1ldHpsZXIgd3JvdGU6DQo+ID4gc2l3IHRyaWVzIHNlbmRpbmcgYWxsIHBhcnRzIG9mIGFuIGlX
YXJwIHdpcmUgZnJhbWUgaW4gb25lIHNvY2tldA0KPiA+IHNlbmQgb3BlcmF0aW9uLiBJZiB1c2Vy
IGRhdGEgY2FuIGJlIHNlbmQgd2l0aG91dCBjb3B5LCB1c2VyIGRhdGENCj4gPiBwYWdlcyBmb3Ig
b25lIHdpcmUgZnJhbWUgYXJlIHJlZmVyZW5jZWQgaW4gYW4gZml4ZWQgc2l6ZSBwYWdlIGFycmF5
Lg0KPiA+IFRoZSBzaXplIG9mIHRoaXMgYXJyYXkgY2FuIGJlIG1hZGUgMiBlbGVtZW50cyBzbWFs
bGVyLCBzaW5jZSBpdA0KPiA+IGRvZXMgbm90IHJlZmVyZW5jZSBpV2FycCBoZWFkZXIgYW5kIHRy
YWlsZXIgY3JjLiBUcmltbWluZw0KPiA+IHRoZSBwYWdlIGFycmF5IHJlZHVjZXMgdGhlIGFmZmVj
dGVkIHNpd190eF9oZHQoKSBmdW5jdGlvbnMgZnJhbWUNCj4gPiBzaXplLCBzdGF5aW5nIGJlbG93
IDEwMjQgYnl0ZXMuIFRoaXMgYXZvaWRzIHRoZSBmb2xsb3dpbmcNCj4gPiBjb21waWxlLXRpbWUg
d2FybmluZzoNCj4gPg0KPiA+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHgu
YzogSW4gZnVuY3Rpb24gJ3Npd190eF9oZHQnOg0KPiA+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3
L3Npdy9zaXdfcXBfdHguYzo2Nzc6MTogd2FybmluZzogdGhlIGZyYW1lDQo+ID4gICBzaXplIG9m
IDEwNDAgYnl0ZXMgaXMgbGFyZ2VyIHRoYW4gMTAyNCBieXRlcyBbLVdmcmFtZS1sYXJnZXItdGhh
bj1dDQo+IA0KPiBJIHNhdyBzaW1pbGFyIHdhcm5pbmcgaW4gbXkgdWJ1bnR1IDIyLjA0IFZNIHdo
aWNoIGhhcyBiZWxvdyBnY2MuDQo+IA0KPiByb290QGJ1azovaG9tZS9namlhbmcvbGludXgtbWly
cm9yIyBtYWtlIE09ZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy8NCj4gLWoxNiBXPTENCj4gIMKg
IENDIFtNXcKgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4Lm8NCj4gZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYzogSW4gZnVuY3Rpb24g4oCYc2l3X3R4X2hk
dOKAmToNCj4gZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYzo2NjU6MTogd2Fy
bmluZzogdGhlIGZyYW1lIHNpemUgb2YNCj4gMTQ0MCBieXRlcyBpcyBsYXJnZXIgdGhhbiAxMDI0
IGJ5dGVzIFstV2ZyYW1lLWxhcmdlci10aGFuPV0NCj4gIMKgIDY2NSB8IH0NCj4gIMKgwqDCoMKg
wqAgfCBeDQo+IA0KDQpXaGV3Li4gdGhhdCBpcyBxdWl0ZSBzdWJzdGFudGlhbGx5IG9mZiB0aGUg
dGFyZ2V0IQ0KSG93IGNvbWUgZGlmZmVyZW50IGNvbXBpbGVycyBtYWtpbmcgc28gbXVjaCBvZiBh
IGRpZmZlcmVuY2UuDQpHdW9xaW5nLCBjYW4geW91IGNoZWNrIGlmIHRoZSBtYWNybyBjb21wdXRp
bmcgdGhlIG1heGltdW0gbnVtYmVyDQpvZiBmcmFnbWVudHMgaXMgYnJva2VuLCBpLmUuLCBjb21w
dXRlcyBkaWZmZXJlbnQgdmFsdWVzIGluDQp0aGUgY2FzZXMgeW91IHJlZmVyPw0KDQpUaGFua3Mg
YSBsb3QhDQpCZXJuYXJkDQo+ICMgZ2NjIC0tdmVyc2lvbg0KPiBnY2MgKFVidW50dSAxMi4zLjAt
MXVidW50dTF+MjIuMDQpIDEyLjMuMA0KPiANCj4gQW5kIGl0IHN0aWxsIGFwcGVhcnMgYWZ0ZXIg
YXBwbHkgdGhpcyBwYXRjaCBvbiB0b3Agb2YgNi44LXJjMS4NCj4gDQo+IHJvb3RAYnVrOi9ob21l
L2dqaWFuZy9saW51eC1taXJyb3IjIGdpdCBhbQ0KPiAuLzIwMjQwMTE5X2JtdF9yZG1hX3Npd190
cmltX3NpemVfb2ZfcGFnZV9hcnJheV90b19tYXhfc2l6ZV9uZWVkZWQubWJ4DQo+IEFwcGx5aW5n
OiBSRE1BL3NpdzogVHJpbSBzaXplIG9mIHBhZ2UgYXJyYXkgdG8gbWF4IHNpemUgbmVlZGVkDQo+
IHJvb3RAYnVrOi9ob21lL2dqaWFuZy9saW51eC1taXJyb3IjIG1ha2UgTT1kcml2ZXJzL2luZmlu
aWJhbmQvc3cvc2l3Lw0KPiAtajE2IFc9MQ0KPiAgwqAgQ0MgW01dwqAgZHJpdmVycy9pbmZpbmli
YW5kL3N3L3Npdy9zaXdfcXBfdHgubw0KPiBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19x
cF90eC5jOiBJbiBmdW5jdGlvbiDigJhzaXdfdHhfaGR04oCZOg0KPiBkcml2ZXJzL2luZmluaWJh
bmQvc3cvc2l3L3Npd19xcF90eC5jOjY2ODoxOiB3YXJuaW5nOiB0aGUgZnJhbWUgc2l6ZSBvZg0K
PiAxNDA4IGJ5dGVzIGlzIGxhcmdlciB0aGFuIDEwMjQgYnl0ZXMgWy1XZnJhbWUtbGFyZ2VyLXRo
YW49XQ0KPiAgwqAgNjY4IHwgfQ0KPiAgwqDCoMKgwqDCoCB8IF4NCj4gDQo+IEhvd2V2ZXIgd2l0
aCBnY2MtMTMuMSwgSSBjYW4ndCBzZWUgdGhlIHdhcm5pbmcgd2l0aCBvciB3aXRob3V0IHRoZQ0K
PiBwYXRjaC4NCj4gDQo+IFRoYW5rcywNCj4gR3VvcWluZw0K

