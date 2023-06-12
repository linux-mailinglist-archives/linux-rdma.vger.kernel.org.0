Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B331772B8F7
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 09:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbjFLHpG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 03:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbjFLHpD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 03:45:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514C3172D
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 00:44:36 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35BNajlY018473;
        Mon, 12 Jun 2023 07:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CE5pVC8lEVQJBcPPNOgFkiTF/CxlaWZUlURvkcpv8WU=;
 b=RWBwQTOxXU+UaJO3CMMHfhzERT7P3/riOqZtOXiwUm2NuPXwNz54igoYP7TzN0D6i8NY
 FJe69rpBzhSaEA3OukyD79Pmwss3BkAfAD2cF1nfKegrzcsjeEfSUuKjdsf3ulwW+Wpe
 yTuCyfU/tkpCSeIesWAxj1LWzdZB0r7pMhqCXdN19yn7CbpmGHsINcToCcZBt+DXvKWU
 qMkXSU9RIypevR6G3JDdFsSb2WI2syep6v72vOj007ENk0KDXIrbfTAZI0TXn2m+NWwQ
 E9ReCTOS3wp9qNwX/BsnatFeOeI4rJH5gsG5OYp924IKVY81NMDJcI1icCRanguc7Aml /Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs1t702-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 07:43:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35C7CRDS021596;
        Mon, 12 Jun 2023 07:43:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm2f1sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 07:43:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AukZ6Q/Vfbn375e24FCblX/0PhiLvkBNFQ36ItCpUODdBvtQ4JPJ+AYRxPVcZrm7W6kKcInoY44YN257VvFaP9oFQ6IlAWlhC7mQ2lBW4tVym3PtE2Tg2A+Yhx8BX68SJ5b1uSPykY7y75ziAs8HM2wZvX3/kqvctUM+ZZ0/Ilv6zI/08fyORE7/lzBLudbqAkJ07Ouqe0m5xAcGBaY+YzNFA2PvTaEdLynnIL0I3Tm2iy9Usa2w3WWziY/s3r74ZZOfU5VBf8OZNnrk7QvNgCPqMMVSXHf+a5keDZ9YNMvNu5u1e7xs1BVmNaUz1De7PAZaXx1/HneUiYnJisTTAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CE5pVC8lEVQJBcPPNOgFkiTF/CxlaWZUlURvkcpv8WU=;
 b=G6hqLLu/tnU80skjeGZy1T5/uVmOkFjCmZq+Na7Bwt4rHultiJQGdoI/qZUtgmoYoL774ThsQOQFRyuFgvR7KtuC+hyn7F69Gq4DotDRovjYv7D6Tl6uV6yZmduAomIA04YxbEu5abdWhdzLK06LbYq2PUhdapAvy5zy5soFj5dFaeIZlPbWoPtjxCMePkxS+ipcm2IGBnj50ugR2QU2z0ABE7ZN8wch81vYTNoF5JRhJmzANMR7kXo4vjHE81Zo9oXCbURQqKJOn9goEGwIU2ZsCX5WfT+5PPxXzzZLf7z3dmhCnr683F/jQnZ4Kg0bl9tS8AUqVVkLcWhEQGU+tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CE5pVC8lEVQJBcPPNOgFkiTF/CxlaWZUlURvkcpv8WU=;
 b=KKNB5gBUjIycwEu0T09pzNckl8SQkWpjzSM9EyE9gjpWiXJg0zDQkCu2xHHp3kmC8NtsimHpvooCq6yOM4AgPcyzl5VFaE4qz2er3Zt7An0P+2Qp9yt4va+SlFkM9jadXBmXAAUXPHFxRueY7DksSf+P49UKIc02gJj+r3+b7iE=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by SA3PR10MB7093.namprd10.prod.outlook.com (2603:10b6:806:304::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 07:43:02 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::e53a:31e3:d66d:6fdc]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::e53a:31e3:d66d:6fdc%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 07:43:02 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Question about SQD in the mlx5_ib driver
Thread-Topic: Question about SQD in the mlx5_ib driver
Thread-Index: AQHZhCPqUZN/eCAA/kSEvXMV7Bggma+Flh+AgAFklIA=
Date:   Mon, 12 Jun 2023 07:43:02 +0000
Message-ID: <EE9BFAB2-CD11-452C-A498-2676604719BD@oracle.com>
References: <6F7F6F24-2AF7-4BBC-9D6C-70C8CC451A3B@oracle.com>
 <20230611102637.GC12152@unreal>
In-Reply-To: <20230611102637.GC12152@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_|SA3PR10MB7093:EE_
x-ms-office365-filtering-correlation-id: bbd6c2a6-ed48-40d9-a9cb-08db6b18a6e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aqcw2FcOIFy1Q2n/cpdihLuvzXdOFluTCTJbmKI665hg1ktmeLCrnylp3xS4stTTFdSlJvnqVm8QR3A8szSZ+u/M9u+BGMpMNrGgocYpas3b9BXArDTFAHCrKiwzUJZBKZRUEsz0EgyNCE9Xhiwp+sK3O2xYhA/iZw94wTnJh7CfCdCI1HcUi2Z166Jkd7yHI/2oC84HbYex3pxYBkH5/lsrwylQ73VUXv1boSLuoEJnQstXwBouPQeml0pHLQ+AiNgk4IE/n3xsXI6qZ/rdmDMJSHYo90MznoRTtXFZIzUbLZ7muvCvNu5qWJg08MZQ36CysJyFC/fBKgHWemSExn9tU2brvsx6BaxIJz3WDRgaTV2OO0iDwLAXAyO8XVPecRzhn9TjzGEDQbM4ZQICIEQ2MkV6i5KYmfdezDqA4ZW03o98Fjyrv5mcp+guuShCNSqv4FHR3rxBYlR+8jyOKNE2j4NwtIHMQWuDhUNpimZOagZtabPqADOmFLVle+q+BBsDnc6nS8xuy8c8RnTg5i81Zy6gVLHj3waHwAcBij8untaSN+HtaK9KcfLw6muRIQQIK3jt1u0jIMUXJfwpXQ7cPYkyM7YLiyxeXgcW2O8LgYzE5DAQavIA1tRCKX58JQ+k5cnmKiMCRSQdTNWzuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199021)(8936002)(66556008)(6916009)(76116006)(66446008)(66476007)(8676002)(4326008)(66946007)(91956017)(64756008)(5660300002)(316002)(41300700001)(44832011)(2906002)(4744005)(478600001)(38100700002)(122000001)(6512007)(26005)(53546011)(186003)(86362001)(6506007)(36756003)(71200400001)(6486002)(2616005)(38070700005)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ni9PR0ljT2ZrVWNRZ08rMHRNcWM0ZHBpYUp5blhadmV6a2w3V2pnMkpXK3lX?=
 =?utf-8?B?YlRERlNwYXlQTEpzZHVpRnZQbXhkS2NqcjdiTWw4VjZ6dy9NVlIvaG5jUU1l?=
 =?utf-8?B?TnF1MVhqS0NiZE5IWmNwcXZJWXRNcXFUT1JTRlk1clY3andCbkZDNkhrcWQx?=
 =?utf-8?B?blRXR003dmp6NFp3UWZqdXkrMkY2N0ZsbTNKcEdYYlp2UTgxZGszSjZqL0d2?=
 =?utf-8?B?dFpZL3dmUWgzVGNSb2R2S3F3N3dObHcrY3pVTkJnVmVsOGExTTBMa0Z5WE52?=
 =?utf-8?B?aWVZa3h1eFlWM256TnVvcW5CaFVpZ3YyejdiSUYvMy9DYXlpSXdaZWNrbXFP?=
 =?utf-8?B?VjFEQUZwV1F4dlRYYjFMTVdhRmlVcGQ4VmdkaWhIRXZuQ1pFOTE1WU5yNkhB?=
 =?utf-8?B?S2l6Zk0wMWxFRlFCWWRRZEV1N0o3NVdvL0k3clFQbWRRZjVCSis4dXlPRFJy?=
 =?utf-8?B?SEVDeWhHbk1YSm5iNDdkTWFPdWRMQWVMWm84YlJxTTdLVlYycy9vcUZNNWdM?=
 =?utf-8?B?UC9rOVVITkRYWVRjaWZ1bGtaQmxFSVhFWkNGUUU3YmhEZUVPQmpVdXJQdUJr?=
 =?utf-8?B?bjRLMXNCbk4zWkhBNmYxenNEUWQwZ0hwQXdRRm9SVzVmM0FKdm9KMlRhcFBm?=
 =?utf-8?B?QkR2VHJJOVhZcnNGMzdZWEp2bi9VM2tRL3ZWWTF6ZitDQkJJbVlYOXh6aDB3?=
 =?utf-8?B?WDNQSHg4QXJhN2lDYmlMcXhLa0R3L3ZYRnRBM2Y2dzFsUENacWhGeTlUN0dx?=
 =?utf-8?B?UUFSME1Ga2t6bE16VjRQOXAyQ3ZUNFU2SG9JZzJ6dHVlNlZJYk5Jd1ZlY09P?=
 =?utf-8?B?M2h4eW9iSW16MlJmUlpPUzRSUGtWcE00OFdXQ2o1b2tNTFNFVERzQlRnYWR0?=
 =?utf-8?B?VGpsVUtOZVV2KzhCVG0vL2tsUjRzM1ViMC84TzdPVjZwdVIvSFZGT2JOTFNP?=
 =?utf-8?B?Ykg1RXNDRlVhbFJWa0hTeEZPczFpZjJML2xRWmJ2elVQeGU4bDFyaGJURmlC?=
 =?utf-8?B?cjVzQ1NZZjFrSTdIZ1pUL0NUS3QwVEV5Z01NYXM2dnEwcCsrVG44QTBHZzRG?=
 =?utf-8?B?RGxPU1RmRE1aYkJXYW5uQU1pNUtkZU8yR1VINFlNMjN0R3h2NXRDWUo4aFZn?=
 =?utf-8?B?MmhxcE9HS0p6TWIyMWlWUzJuaEo0ZXBLdWRXRG1FazFKVmRkVEx2V25MY0tM?=
 =?utf-8?B?R1pGOFZIQ29lRWxyUDQ4WHZSK0FwaHVTQlZNc0l2L3FVSHhUaEhhaUhWZ2JK?=
 =?utf-8?B?azVUY20ya3dZOEF4bVlwSWNmTVQ0dDgxNWxSVFBGUzIzMVhiM2RDZXU3WGJp?=
 =?utf-8?B?V0kxNFNMMEJQSkN6bjBUazI3bUp6NEYyQXBQbm94MFkyWUVRWkoxbFVKWWxE?=
 =?utf-8?B?Q2lvdHFmd0hvNzMxMlB3RWF0M0diNXcyM3VhWmViVVdzKzZGSVhaUDFkdFZh?=
 =?utf-8?B?OE05c3krQXB2TkNpL1gyaGdNNUp3NjBQczdlOHcwWFg1OGFYc21Td2V2K0VH?=
 =?utf-8?B?NTBEdXY5dTZlczB5cVBHWVJqNjJEOGlLNEJXeDNUVk1IaTZJWmprMFhLc0xm?=
 =?utf-8?B?ZVZ5akt3ZzdreHJCamVTTXJySFNmRmhWUHNPYlBRS1RjQlh3WXVtUjBrRTYw?=
 =?utf-8?B?TldhM2tFTUtlMEtrMHpVOFJsRmVxQ0FzT3VQWUoyUzZGNkNPaFRZc0Q0YlBz?=
 =?utf-8?B?SGJKbThNN1Rwb1VuSHNkMkh6ZU1iZUkwQmdlSEtFbllmQXNEaUIxRmhITHhq?=
 =?utf-8?B?Uk5LOTByRGpvV0xhUHVLMDl6a0xIeWp4cDBxbjA5MFdWMmw3UmlscUczUm9u?=
 =?utf-8?B?aUttN0duMm83QjQ5YzJmTHVOOEZzdGkyT3NZcUtDbXNtUWFTZ05kSDRTVG44?=
 =?utf-8?B?SEFXT3ZoUnM5VFlHNnFpYWpNVUEvaWt0d0h3OXg2RFVDZDF5Tm1teGtSc05m?=
 =?utf-8?B?QW4yeE5QZVFxN0grNkZnbWhyaHVBMlV5ZXpYd21ZK2ZPaHVzM1ZrVkdoUVgv?=
 =?utf-8?B?QWo5Ty9ia3BUMGhudTRCeGgrUUZWUVVTZW9mUU40Y01ONzhDNmFaTFhpY3pL?=
 =?utf-8?B?dVB6R1pDOGhJU0Q0L3M1MkpBbHpXaGEydHp2RzFsSUNjZ0lkd3hOMktjYkh5?=
 =?utf-8?B?MmRHQkpnSjE2ZTgrUWdpcnFnaC8wZHBYZlBnUDBEc25QME9VRUNJUUZvRzdC?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E514E6136770B94EABA5BA65077271C9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fLA1HOz8sxlbK8g1zVWAoo3c7IS93PQwCX+C7A4r/HV5CS2vEByuTVUXkXl5Eamgpo1WuL1vVleNAwpU8+oAp2SebwgmAoBNPZ7LKq8SysmAykJWebxZRhiReXyufqOAXYbd79kTNfHjhfuEH1qMhFkwy74diD3KlZkpnDIatkODhaHzpm9YFl0flhvBD8+YEwnFRDVPXpOdqW2s+pWsNDfdNgPQJ8YLdIsGHBqSnD3TQmqIoVOaPRxHVFvLz9C0no/fpJWpnut6nnGEQiHo8nyIGkWNqzKCNk23HUJ4TgMfGYLvu+Q1Nz4BGaFmfXvkQ/ttSByZEAcGx28tmUkIKrftruLsQbahUWWN/NiazcuwXZvDS3CA58c/2YWOPJC0Bn7Gm4atrEo3wIpBvZ/XvCZtgD8gfzO2bIiHcYOiLXBRQk9LNgf89Khlff/lqgexn1sXQgoRfGDmahkzzzRIFndMcVtHneVOPDEWVnXLjs05StPV5bhKMsTtHRPrdRRYUesSPVThocqfLpltIOdqN5cBa2x6G2kw3neJcam7mPO6XUEzRLM6I2//S++zmPPmsPFXH6vB8QxggoY835IuTL9fllNgz+DT2JpPyGiydrk+qvnmQhR+9oXkM7ip01u15ce7Y9NOAP4lSfSS9xxPGzhGVJ/nf+CskmtzVdEIPXDDaKbJY+cyLXtrea//pRf3Z/yqd06wD/bzb+TloV1zy0+9EvKscA5+COvCveWXcteLhXoTN/g7Lg889A+brKF8fEwXmRuZ4MDVeaRD/yFURsvQNhYUjXbWPvSlUwUrVhw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd6c2a6-ed48-40d9-a9cb-08db6b18a6e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 07:43:02.6218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MKldJe75Len9UkGjNouveCNuiXVNUwV0DFfpkMLoFkeGxjCyL8KYCq8bG5LEN79jy1c7YoXR2d5G0v0A2X0L7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7093
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_04,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120066
X-Proofpoint-GUID: RXvI_wagqSnLDW9XYwlcz9Eh3GnGmhAN
X-Proofpoint-ORIG-GUID: RXvI_wagqSnLDW9XYwlcz9Eh3GnGmhAN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTEgSnVuIDIwMjMsIGF0IDEyOjI2LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIE1heSAxMSwgMjAyMyBhdCAwNDoxNjoxNlBN
ICswMDAwLCBIYWFrb24gQnVnZ2Ugd3JvdGU6DQo+PiBIaSwNCj4+IA0KPj4gSSBzZWUgdGhhdCB3
aXRoIGNvbW1pdCAwMjFjMWYyNGYwMDIgKCJSRE1BL21seDU6IFN1cHBvcnQgU1FEMlJUUyBmb3Ig
bW9kaWZ5IFFQIiksIHRoZSBkcml2ZXIgc3VwcG9ydHMgdGhlIFNRRCAtPiBSVFMgdHJhbnNpdGlv
bi4gV2hpY2ggaXMgZ29vZC4NCj4+IA0KPj4gQnV0IEkgc2VlIG5vIHdheSBob3cgdGhlIGRyaXZl
ciBjYW4gdHJhbnNpdGlvbiBhIFFQIGludG8gU1FEIGluIHRoZSBmaXJzdCBwbGFjZS4gSXMgdGhl
IFJUUyAtPiBTUUQgdHJhbnNpdGlvbiBtaXNzaW5nPw0KPiANCj4gSSBzZWUgdGhpcyBjYWxsY2hh
aW46DQo+ICBfX21seDVfaWJfbW9kaWZ5X3FwIC0+DQoNCkkgY2Fubm90IGZpbmQgU1FEIGkgb3B0
YWIsIHNvIGhvdyBjYW4gUlRTIC0+IFNRRCBiZSBzdXBwb3J0ZWQ/DQoNCg0KVGh4cywgSMOla29u
DQoNCj4gIG1seDVfY29yZV9xcF9tb2RpZnkgLT4NCj4gICBtb2RpZnlfcXBfbWJveF9hbGxvYw0K
PiBtbHg1X2NtZF9leGVjDQo+IA0KPiBUaGFua3MNCj4gDQo+PiANCj4+IA0KPj4gVGh4cywgSMOl
a29uDQo+PiANCg0K
