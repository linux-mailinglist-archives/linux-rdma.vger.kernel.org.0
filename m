Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0E948B260
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jan 2022 17:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350089AbiAKQjM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jan 2022 11:39:12 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30574 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343677AbiAKQjJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jan 2022 11:39:09 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BFECkm021137;
        Tue, 11 Jan 2022 16:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qYUimI/oBafc8eML8PiDAN9lHGmyYDPmFrGDjCkveao=;
 b=BxjmSqIk8MF/9BolZ65xrbnfPTI3jeCwaNaRzCJL9JshPsw4B5P7ZlptPIVLvT+2D5j2
 S/s7Vw84cdJrN0GJ1uTm88Pmwwv9fTJ95lVSa2+GQYJHl7KBu3/4uCZV9BFZj+iqMtGn
 uwulKl4tAkkMOrPRm8bs+nPYevF3C75QA/mBrRNABF/L8RD9TM3IN261lZj36evyVWKt
 nwMLRZh0WgzXaNsUDAYo8zllPIwNNEsKMKWCh4dOXGCWYjugkTIDaLTpa+jzgfM1Q3de
 WGXQKPPMo2gmcthcX6qdLiDMZFMRt4snu1PUtf1qSVb0P5PUvLCGVqNWT+RfVnk2XsaI VA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7nkfc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 16:39:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BGTxJf019736;
        Tue, 11 Jan 2022 16:39:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by aserp3020.oracle.com with ESMTP id 3df2e50qhy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 16:39:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgNrVmPGZzMtxoD0iCvJGBPQEi9TI83MYa+IXrv4HTdhB2At+NfYdlcCiAxatlNmERNDpCn0t3PdA0RPPXtzge5soDWAWvhxvf/WNgHSRdYNFLTtkBUq9jhSaRuO07ILKDFUe7ZC6zrtiCM7envUOTBF7aRFLc2Ba5y5mOpLvdSiuDyMndJZ1oe8nzt4/+bIF2JPPMDbgM+wDlXdV4dL8yFZgZDap82P0vH3E/E0PhkESOJ94WDhSwkfR0a48Cthv8zIG6GFzK/dpwo7bDQZO9praLpKcYnhgan3V9eTkRSzRbmjyqx5nL/b9FzcysygaqYCU7a6JXESXbDMxOvsJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYUimI/oBafc8eML8PiDAN9lHGmyYDPmFrGDjCkveao=;
 b=HYPEGhfAaPBQJl3cVsZUYfghHvJnJEgR0J6Urtv8uspG24AxneXSQKDkbM1+T2eDdKQZLCK/27cKNvwO7YizNjYOTJ7RB5UXj2kHRXkHp2Au7SACKUWWxZFhlyvWrQmfPqVCuMnBkpAnU2Yk6nShvv1rb1AHVksJgz7KiCQLqm2jYlLJYC4yT+1MnOQOJ2Xo27o7FoW3ZeL+wsxSssYNanXLQI93by+ZBuoxmeo9B1P832aaiFbpUqGyMNjdQVGxUwa63U29A69O75FA+QbmD7EegytxRxxxpQtfjITqIuu7Nvy4B1NYd7Xl/B2l3HhtJ/1+wO+x+SJFNLdI1vAxyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYUimI/oBafc8eML8PiDAN9lHGmyYDPmFrGDjCkveao=;
 b=eHdOezHVn1P9bY8e4wyFubhAvBTlsvHVqdEuBro+7kq3UiUgIQA+zjVHZqMSqTmCEHd0ScGS4IZHAdprZCnEnRbf2rPOTyZ4HeoemNp1lS8X97H8OCA6ZDZteIIc8WaggOUJy0YWPxMgw2Z3A7MoU8M380DAyB0vQxK8Bwa4ljM=
Received: from SN4PR10MB5590.namprd10.prod.outlook.com (2603:10b6:806:205::5)
 by SN6PR10MB2430.namprd10.prod.outlook.com (2603:10b6:805:47::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 16:39:03 +0000
Received: from SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0]) by SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 16:39:03 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
        Or Gerlitz <ogerlitz@mellanox.com>
CC:     OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC for-rc] IB/mlx4: Fix the fix for reading flow-counters
Thread-Topic: [RFC for-rc] IB/mlx4: Fix the fix for reading flow-counters
Thread-Index: AQHYBwlQCvRoMTPPuEKfYe0lhfeCNaxeBTSAgAAANAA=
Date:   Tue, 11 Jan 2022 16:39:03 +0000
Message-ID: <E392D0EF-5C0A-4844-9455-4BD0B5FDE04F@oracle.com>
References: <1641918938-10011-1-git-send-email-haakon.bugge@oracle.com>
 <5106B29C-9978-454D-9D25-84C29B110105@oracle.com>
In-Reply-To: <5106B29C-9978-454D-9D25-84C29B110105@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3813182-4428-406d-6b4d-08d9d520e0b4
x-ms-traffictypediagnostic: SN6PR10MB2430:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2430346C52B3BC39400E4581FD519@SN6PR10MB2430.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uCwcHeeYE0Zs8BVdxcjyJlrupnXMGs79IxHjBjy3K5Num4q+FNqIiUD/ecGKChBqeOeJZ5+f+1A8idl/tcuWSpM8YmJ5Oeo05XqD+aWrs6YcYkuo2v/9o/BSoX6+9FGvAwxF2Auupxe6WPW1oiIGv//qc2NNCMwKGbbBg/fmg6b7SNiBpZCGg9COnXcq/7qYF+2gVqwYLqHE94d9ZlBVSeCCmNwU35BP09i4evsABl1styi9eaqgT/9cSaqKKsrvZJgyN5Y9eTPes6yEXBt581Vk9KXFDSK34WyETkt3OZrTAJSpTloVtv28EuL9t3Zj3OD5poef8EMlndXfh8eggPRv/lzzbm2OOf5GIO90a2SGqUUMPrHxgEM/bJJvy+gPFcrXPBZbSQzXHtTfOYijoip417IVAB2vBlikgkskNs3kZwyjj2biSQ3Zpjoc6S3BJZ9izFaV2bPp3CeUFUGfalg62jZ5hhQlinY7U/tBbWU3643uHkS8sgt8ITpQUO270RrE+5W5KpXifMAWMCcBBINN/Du4qTD2BbA8gMJo3FZKFYEBUwlyuHzlXCL4FmaNfOEQEoHiTOvCKdj92Oi2x841f/xk8uS2myrHypfG8qm/tNXlF2iu+qXerSxO5DQwOWb+4yTOxGKhO/TV1avJI+v8F1S/fKXfBPkZ9OmdQ/mMtgGnujgwc6bBv6sTcGsC5bhM7AbIl+jw4sgu2VY79SQkfJnFh8eRZgEDrEpyATVScKwjciChlahkELYqYQx4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5590.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(33656002)(53546011)(2616005)(83380400001)(71200400001)(6486002)(508600001)(6506007)(54906003)(8676002)(186003)(316002)(110136005)(5660300002)(8936002)(66476007)(86362001)(4326008)(76116006)(26005)(6512007)(66556008)(38070700005)(66946007)(38100700002)(64756008)(122000001)(36756003)(2906002)(66446008)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TncrVWhkYnp6UzlvMHBldDIvd2FjcHc5bFJLUzF2VTF1VldEbUtCcWZtSlVw?=
 =?utf-8?B?T3JpQkpKMzNaT1pMdXBsbEIzR3NrQ0RXSjU0eXZNbVZFaEpWRUFZamtFY1pF?=
 =?utf-8?B?SzMwaGg0TTJTTytvVllYWHp0S0labU84UkFDT0k1cldEU1AzRW5kZThtbmoz?=
 =?utf-8?B?V095UzBSNUNMOWQxUG1xdnJDeWh5b25oTTVDRmlqekdvOERYOXBQcXFIM01L?=
 =?utf-8?B?T1NNZmVTRW1UbWVUSWl2cU5JYnRUVCtJSTlnVUo1TW9DV01ONzFjSi9pNkVX?=
 =?utf-8?B?RmY4MXczSmI5RDM1aDY3ajNSZXdjVU1ha1pFWGlET1JqdWNGSm4yWVdiVDVZ?=
 =?utf-8?B?Q2hTQVhUWmZ4bkJLYnl0RU9mSmdaLzVEYjBrc09mbzJFQTRvZzB4bVl0SG5Q?=
 =?utf-8?B?QmtPQ0tla3Jyc3ZWSVBGcGdNcnpwb21rZHFBaTFsSGtzWmxieWZuaTBzTUN0?=
 =?utf-8?B?N1FkYnlrUVN5cGRKNXNMbDBXVm9OUmgrcFg2WjUrKzBteFNENU1iaDlnQi9B?=
 =?utf-8?B?VnhERjFQN0JhQldSSFZlRkdkdFN0SFBaclRVdmJDVGNHdDFFNFB2dHk2UDBH?=
 =?utf-8?B?MkNNcERLMkZRcndYRFRZNEQrbmZkbGhQbnJ2VU9icEFVQ0k5MWxBR3Qzc0VB?=
 =?utf-8?B?OElXeUs5NFpDTEtyWFZ2SnRySG9kU0p2M0NuQXFCZmpXNm12cVNDRWRaRzJ4?=
 =?utf-8?B?SHI4cG5kMkg0T3hXVmdZUVl2MldxS0NUdEs4UUhkczJ5b3pKU3NxQjVzc2VC?=
 =?utf-8?B?c29JdHZvYURGUXdDZlV1SHowWXF6eDl0RzF0cmpQakQzNUtPL1ZQMDN1M3or?=
 =?utf-8?B?M3gzVGVlSlFBZTFrVHZ1R0d6SG5jRDBFQlNFUnc4Zytub0daYXhxL0ZhMTlK?=
 =?utf-8?B?MEFGbXBESE51Wk8yTVNPVU9mQURoSEs1RjByYVcvdG55ai9wTENzYnYxd2lo?=
 =?utf-8?B?cjlNcWxDRTFKenBZSDEvUDZFRXhONUtQNEh1TmpxT05BU3ZrNEtxanV4aXR6?=
 =?utf-8?B?Q1pXczdMc09VZXVGVTM1ZEtHTEI2OXR0WlVUME80bTRIZHZNbU81R0NyWnlN?=
 =?utf-8?B?MXc0NEVwZnp6K3dRVDl5QVJFQnhoRkVOY09IZHJrUUhPZDA3MUJCZjlQbUk3?=
 =?utf-8?B?SzF0ajZ5MlBYeksvUFAxZWN6MUlOSWQ3NGtXVG9DdTlTYU5weXRROHc3SWRr?=
 =?utf-8?B?NWhYWHU0RFovSHkvOHVoa1BVbSs1UHBHTXloMjF6VzhWTnNyaXlMY2NxMVlw?=
 =?utf-8?B?MkQrVUNzOVY0YXorOUVGSmgzRFRtMytzdzZueFl5bHllV0dnRDg1TU9hQTE4?=
 =?utf-8?B?SXVZR2tpMVNoNUpZeUlHZE5OWVRVd2tyMTR3VGlFeWJrMmZWS3RxT0pSSXN2?=
 =?utf-8?B?NUhnc251eHhMcTMyNFpjR0laNXVhOFRsRFNCNE9PR21EZjZQYWxjZklNeXg0?=
 =?utf-8?B?WGZqc2l4dkYwKzhoaTB3R1oveXB6U215MVhOdnNIT2wySkFmenA5bVMySWg3?=
 =?utf-8?B?aTdtbWVKcVhjZW0vV1pIYm9pcWV2N0VXWnBxRGk0cHIvS0xLcWFaTk5YaE1U?=
 =?utf-8?B?dHZUYVdQblVMWXA5RThlV045azh4NFA3ZnhERC82NUdVK3F3MjRmbDlYV2Vw?=
 =?utf-8?B?T0JXSlRaMDdpL1AvMFRvdW1LUWNpUW4rRDQxS0NNMkQ2Rkd6RGRkclJFa1dr?=
 =?utf-8?B?NXpQRGc2cS9Wb1dnRE1jcFFLRUg0T1QvL2lpOVpyclI0YVIyUGFjYWRvQ0M2?=
 =?utf-8?B?RFRERDYwN2hSeGJLdDlHanM4Um9URzZLemt1WXQzWmlaR2dldTltc2ZMc0Ex?=
 =?utf-8?B?R1g5VTQwbllXanJ6cUNKYkdzQTFycW9tekd3SlA5NTU2M3lNWXRpVCtVSU51?=
 =?utf-8?B?U0IyOGpsd3phdDNadFJvN3ZIKzBKdytBSXlGemloYlFnM0NPaVNBVW5TZENU?=
 =?utf-8?B?RkU4NEl1ajhTMExmdmkyOW1yalh2OFB6cDE5SDd6RndqZ3RPQnNxRUNWY2JD?=
 =?utf-8?B?TE92SlpKdzh2eG85ZCs4elBlc2I0VXRScjhBUHhMbEtuNmlEVmx1aXpLcUNm?=
 =?utf-8?B?T0JCQ1VaRTNicXdvd2pyYzVDUmNaM2pGbmUxNjllb0E5Zi93a1B1d0x6ODha?=
 =?utf-8?B?Q1RwMlFycDNraE9CMzVBTXdDMlpGVFpUSGZWR2YzMkh3amFZVGU4UXFyRGx5?=
 =?utf-8?Q?Nkqkx5DLUR8vBn22KY4iqiA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E3118E0B183C54E806334A95D9DD419@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5590.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3813182-4428-406d-6b4d-08d9d520e0b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 16:39:03.4132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6cu6RaxWbY0kISm2EryvUjwW8i5ej7URPy2VRNsO720WZfZqgMjebFjjZOjSJNHOI9HUWbrHR9aoiNDd8InMZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2430
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110093
X-Proofpoint-GUID: CMR6-bKqLDdDpM--UspAOEUtbaZw1iPS
X-Proofpoint-ORIG-GUID: CMR6-bKqLDdDpM--UspAOEUtbaZw1iPS
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTEgSmFuIDIwMjIsIGF0IDE3OjM4LCBIYWFrb24gQnVnZ2UgPGhhYWtvbi5idWdn
ZUBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IA0KPiANCj4+IE9uIDExIEphbiAyMDIyLCBhdCAx
NzozNSwgSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4gd3JvdGU6DQo+PiAN
Cj4+IEl0IGlzIG5vdCBsb2dpY2FsIHRvIGNhbGwgaWJvZV9wcm9jZXNzX21hZCgpIHdoZW4gdGhl
IGxpbmstbGF5ZXIgaXMNCj4+IEluZmluaWJhbmQuIE5ldmVydGhlbGVzcywgdGhlIGNvbW1pdCBt
ZXNzYWdlIGluIGNvbW1pdCA0M2JmYjk3MjllYTgNCj4+ICgiSUIvbWx4NDogRml4IHVzZSBvZiBm
bG93LWNvdW50ZXJzIGZvciBwcm9jZXNzX21hZCIpIGV4cGxpY2l0bHkgc3RhdGUNCj4+IHRoYXQg
aWJvZV9wcm9jZXNzX21hZCgpIHNoYWxsIGJlIGNhbGxlZC4NCj4+IA0KPj4gV2l0aG91dCB0aGlz
IGZpeCwgcmVhZGluZzoNCj4gDQo+ICMgY2F0IC9zeXMvY2xhc3MvaW5maW5pYmFuZC9tbHg0XzAv
cG9ydHMvMi9jb3VudGVyc19leHQvcG9ydF94bWl0X2RhdGFfNjQNCg0KIHNob3VsZCByZWFkOg0K
DQogIyBjYXQgL3N5cy9jbGFzcy9pbmZpbmliYW5kL21seDRfMS9wb3J0cy8xL2NvdW50ZXJzX2V4
dC9wb3J0X3htaXRfZGF0YV82NA0KDQoNCj4gDQo+IChzb3JyeSwgdGhpcyBsaW5lIHdhcyBvZiBj
b3Vyc2UgdGFrZW4gYXMgY29tbWVudCBhbmQgd2FzIHJlbW92ZWQpLg0KPiANCj4gDQo+IFRoeHMs
IEjDpWtvbg0KPiANCj4gDQo+PiANCj4+IHlpZWxkcyAiSW52YWxpZCBhcmd1bWVudCIsIHdoZXJl
YXMgd2l0aCB0aGlzIGNvbW1pdCwgc2FpZCBjb3VudGVyIGNhbg0KPj4gYmUgcmVhZC4NCj4+IA0K
Pj4gUGxlYXNlIG5vdGUgdGhhdCBtbHg0XzEgaXMgYSBWRi4NCj4+IA0KPj4gRml4ZXM6IDQzYmZi
OTcyOWVhOCAoIklCL21seDQ6IEZpeCB1c2Ugb2YgZmxvdy1jb3VudGVycyBmb3IgcHJvY2Vzc19t
YWQiKQ0KPj4gU2lnbmVkLW9mZi1ieTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xl
LmNvbT4NCj4+IC0tLQ0KPj4gZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDQvbWFkLmMgfCA0ICsr
LS0NCj4+IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NC9tYWQuYyBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9ody9tbHg0L21hZC5jDQo+PiBpbmRleCBkMTNlY2JkLi5jYzgzNzgy
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDQvbWFkLmMNCj4+ICsr
KyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg0L21hZC5jDQo+PiBAQCAtOTk4LDggKzk5OCw4
IEBAIGludCBtbHg0X2liX3Byb2Nlc3NfbWFkKHN0cnVjdCBpYl9kZXZpY2UgKmliZGV2LCBpbnQg
bWFkX2ZsYWdzLCB1MzIgcG9ydF9udW0sDQo+PiAJCSAgICAgKGluLT5tYWRfaGRyLmF0dHJfaWQg
PT0gSUJfUE1BX1BPUlRfQ09VTlRFUlMgfHwNCj4+IAkJICAgICAgaW4tPm1hZF9oZHIuYXR0cl9p
ZCA9PSBJQl9QTUFfUE9SVF9DT1VOVEVSU19FWFQgfHwNCj4+IAkJICAgICAgaW4tPm1hZF9oZHIu
YXR0cl9pZCA9PSBJQl9QTUFfQ0xBU1NfUE9SVF9JTkZPKSkpDQo+PiAtCQkJcmV0dXJuIGlib2Vf
cHJvY2Vzc19tYWQoaWJkZXYsIG1hZF9mbGFncywgcG9ydF9udW0sDQo+PiAtCQkJCQkJaW5fd2Ms
IGluX2dyaCwgaW4sIG91dCk7DQo+PiArCQkJcmV0dXJuIGliX3Byb2Nlc3NfbWFkKGliZGV2LCBt
YWRfZmxhZ3MsIHBvcnRfbnVtLA0KPj4gKwkJCQkJICAgICAgaW5fd2MsIGluX2dyaCwgaW4sIG91
dCk7DQo+PiANCj4+IAkJcmV0dXJuIGliX3Byb2Nlc3NfbWFkKGliZGV2LCBtYWRfZmxhZ3MsIHBv
cnRfbnVtLCBpbl93YywgaW5fZ3JoLA0KPj4gCQkJCSAgICAgIGluLCBvdXQpOw0KPj4gLS0gDQo+
PiAxLjguMy4xDQoNCg==
