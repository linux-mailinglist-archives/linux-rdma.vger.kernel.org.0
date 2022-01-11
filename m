Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5C048B5BF
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jan 2022 19:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345262AbiAKSfN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jan 2022 13:35:13 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4200 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242309AbiAKSfM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jan 2022 13:35:12 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BI20h9023216;
        Tue, 11 Jan 2022 18:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uXcxWDycfNIKTwpOMAXR7DfDhVdhDGv5uNZ9U7bponw=;
 b=oLdB4CH83kEiARewgmB9udiQgPD1aiq+4w07WVvdJW28vI8YR9p89WC1l2x0gqqPnT4F
 OUheLtYhjlJbaNkehtfFaSSXpNvRie51Co2FR8uJ/aDyj7Kttht1aiQylCNxGGiVD9o9
 pdIHAG6KQkQQ3076XcuzxqAUwxAprXkqwPq2qRZQcklnQkH0LcpwWVNzH9FAPkjGfpwS
 wMalsg/GV4JFMG7EaA4WliuV33QVk+bRghGJU+XLhSkIDZ1y7XtM6VZqWqVdDe3ldup2
 uH+4YUvjt3OYH7YE2/RFIAf26L5v6QICFApVLWOm9lC8G41DfGDMyxORgYfc2t5PiAhl xA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjtgc8u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 18:35:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BIW0LY096652;
        Tue, 11 Jan 2022 18:35:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by aserp3020.oracle.com with ESMTP id 3df2e55et3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 18:35:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U23g751uWBDissiiuSvlc0MnWdtclAR6BE95Kfi6GrGbFopv26oxA69Sp5R5SU8/thbxx3eQN5XgxKVv9hq/6715XpoiVVq1kDAnUBSPWM3wC5mt575hPei+PM6uW4+x4g2ipiZ7u3A03ZKShJVqcGGZ2MVueDyDsMU1l+/hf3GONlShEy8enbPNrqRRSiClHtjQLgVXnYnEQblM3WYdhFu5soRFTdLPq+aaqBtHYTRoZwfB1wb0yJa+i1y49Ra9QtmYfgW9T+5U5mxQKcDw1dHw50B/nf8NNt1rbUOCjfzV2gQKVK+HdaqtEW6CfW22NIH66EMSSo8BQmk9MAq33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXcxWDycfNIKTwpOMAXR7DfDhVdhDGv5uNZ9U7bponw=;
 b=hx+fcoo4Iu1WNQkKPzvG1sg2g0ZkF4S8raCnb4XaXL+Ap0fAn9aQC12EP2WHYLqJKKKyDIWl/WzIG1+HemYnp8nKPNu00EGxgckRmr+YqWruL2uW/vBI2WmlkIWvyrH/tAoKzg0nVDVOcJih5F1LmvGIHp+F/xOqOWpdukzYkR60vvRuz6JEcn9gdkLQzy6e8FAZxeR6aRjqpoNC7sx8NmFqXyC0wy4t8dK3qhw2cXoD4vt9nglu3ywn3r1cxCEY3GfnHhs9UjiZ1mkQ0o/kZOUTCy1IwBOmJBAzI555O/6Rb7X/e9By1hYUFtC51fgtXXYuGCWqVRkAKvey9J9TRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXcxWDycfNIKTwpOMAXR7DfDhVdhDGv5uNZ9U7bponw=;
 b=g132bBEI+tymh9UB4FAFPYXu15ZHrk0LU0ArkaevGiNSw8hR2SiYVXx9PlYwahncvTqnh05QVxiksh8rcQy3/DbVGr1rjx/w2VXxXZgJPBv1BzAc38m7atFTkYXN1JvtayoErIQeGj9o8UdrSbkm5pMgoiDNVcVqurTZuUOVVa4=
Received: from SN4PR10MB5590.namprd10.prod.outlook.com (2603:10b6:806:205::5)
 by SN6PR10MB2848.namprd10.prod.outlook.com (2603:10b6:805:cd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 18:35:06 +0000
Received: from SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0]) by SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 18:35:06 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
        Or Gerlitz <ogerlitz@mellanox.com>
CC:     OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC for-rc] IB/mlx4: Fix the fix for reading flow-counters
Thread-Topic: [RFC for-rc] IB/mlx4: Fix the fix for reading flow-counters
Thread-Index: AQHYBwlQCvRoMTPPuEKfYe0lhfeCNaxeBTSAgAAANACAACBtAA==
Date:   Tue, 11 Jan 2022 18:35:06 +0000
Message-ID: <E2E58477-BF06-4E72-B446-B2398575E292@oracle.com>
References: <1641918938-10011-1-git-send-email-haakon.bugge@oracle.com>
 <5106B29C-9978-454D-9D25-84C29B110105@oracle.com>
 <E392D0EF-5C0A-4844-9455-4BD0B5FDE04F@oracle.com>
In-Reply-To: <E392D0EF-5C0A-4844-9455-4BD0B5FDE04F@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a0b4c8b-9350-46d8-25c0-08d9d531173e
x-ms-traffictypediagnostic: SN6PR10MB2848:EE_
x-microsoft-antispam-prvs: <SN6PR10MB284863D69467EB39A8E32677FD519@SN6PR10MB2848.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tg03fptOzEujqmT3/oS/oR+tBlpeubuOlT/WWQhou64toasMmazq4gkI19RU1hSqtAWP6uEQjWM8wO9OKspgg8BVvLTmVBXpbbjei3A1e/LTAuqF9BBkcRImieZISBbh2Snk/52h20CFmVX3HseFWOqBjkzXh2WOQtwmqqjsC2h7hiO+OweP9tD6hhyOjJvCcEwZcqcUGuK03JVJ362HtZ8BXoDyWLr8ycLMSVno4gV4AQQ03Bq9Bu8qyCyvfzebV9dY1V+fhxHa8hufINuwTUTxmhNFmbJx2ygJxW/FCNpuPGjMO9CWNnPFvH8z10FEG9UJNEBeieoBDWXcexwSmr+/PRkQ0aiL34yivltYzKYsZg+S+PrxxNvCH56uwXplGq2mZBrbeMRvX4iACct0GpH4pwgrD7pz/mqcZL4Rxdpo5wDp+xUTzuee3UC9PuyCR+Zjq2ckvs6i2nPsyFy08eqnnXP2F1p8J5rIdOKNZS1sAgdyooRGfgxUO03M/XkZ7r60DrXkzxLR+lLMLm4KNwUGKM8IIrRcItfQ2028MqL74NKn8JklHqmeTasqLQZfZq5spzHCVTWq3Z4AGjiYZCAtvOkJbDnAROZohZXENGlqTP34GTBXCrVpim6AIge58IJd2gwXEwTBtVlnz3bMD0RkM8aZtjSGaIl+5aF8+LFMgF9OuiwlNoZYkKceT8VCWnuXPLvbFLU6Hwo8YWyiAB6gRSKVSmyREuLt3z2P4cvVCnuVCuKpRF4I+vZE5WPz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5590.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(5660300002)(86362001)(54906003)(2906002)(6506007)(4326008)(53546011)(83380400001)(316002)(71200400001)(2616005)(110136005)(36756003)(66946007)(66446008)(64756008)(76116006)(186003)(38070700005)(91956017)(44832011)(6512007)(33656002)(122000001)(6486002)(66556008)(8936002)(8676002)(66476007)(26005)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVE2NUZOREZTTTEydFBpb3Y5Tk9aK05uK2xnbnprQ0sxZDNjOStrNGdzemQ1?=
 =?utf-8?B?TWdERVVVakIyU2ZhenhzTFcwZmJSY1ZtOUZYY2tLZUZ4Ymk4TzhVTmlmd0NV?=
 =?utf-8?B?cFpDK0FQaUJzY2llNXZINzUrenlpeS9YQkxMWFhncHcydXQrOTFPdTFaRDgv?=
 =?utf-8?B?elV6RWFZOGFLc2ZZazlacURza2xWZ2IwTjA2QWcwSGlGZEVrVnpZWFRJTTlh?=
 =?utf-8?B?UnV0MXBCcEJXMmlOMWsyVDY1WWpMYnFzdHhDMjZNM01iQ2FSdHVSeS9CU0J6?=
 =?utf-8?B?YklMVDRqdm5iNG8zZ0liU3pGTUloaFYwOFBzdENBMEVtbmZhZFcxTzVobm5H?=
 =?utf-8?B?ZVVqanJ2ci82cysrK0RxSDYxQ09IcDBvSFVkM2FYNEl5N0h1QzZYMVFRbW1V?=
 =?utf-8?B?UGhNV1piNVVvTlQ4cFNtS292OFdNVnF4MDlMY29NcThOQjFCTUlGQytESU15?=
 =?utf-8?B?Qm1wWTZ0M0V0cDFnSUFPKzNVU2wvWnU1ZWJkMGFCNW1FTmYrTlpzMXMwM1FS?=
 =?utf-8?B?dXI3dG4wTSt1dVlRTk1hYUFuaGpWRGo4S3ExM2YrVzBVZkFsbkpKdVlYT3J1?=
 =?utf-8?B?Wnk4TVNyakJmb01Fb2trcGY0TVFOK0thN0NkSndwaGk2a3luSGpUQ1dYeWIx?=
 =?utf-8?B?eUFaR1d4b3dvSVJSZmxDd0RSMEs3NFhCRmtxU0d6YW9Pbm1iaEZFK3JMWHhj?=
 =?utf-8?B?RDZISmpKbVdNQWQ3SlZUUXdnVzZUN202ejZTUGV2U2xUTXZ4bHpyb3dxNzU2?=
 =?utf-8?B?L28rWVpqWCthZ0pmeVFDU3h3VTkxRFo0Q0UrZnBFOVpJVmhOQU92UnFBaFhC?=
 =?utf-8?B?RHFNK2tDdExyTmdkYll3SHNFNkphR1NkdmFlSnhOdVNXN2NyMkVVOEE5MUVH?=
 =?utf-8?B?YmZtVFhjMmN0RVlJeXgramc1a003eGxmVGRabUdxYTRTRExQVHZaNGJkWWFL?=
 =?utf-8?B?anlhNnJBV2UrTHFoVUZSOHNiMktvRXhNcEo2SW95N3A4bWtwNnNFVGNGMUNT?=
 =?utf-8?B?VVdIWXJBQ1phcStXK1lnR3k1RUI2TGdqeGU4WVEvM0pXRGIxcWpyUGxyTkNi?=
 =?utf-8?B?T0VZOVpiZlQ5WnFJTHRrNjVRWG1TYnFYSFVwK3VEZFRrdnZhOGZ6bzd4Y09x?=
 =?utf-8?B?ZHFJR2NOME5zRFVtUmovR3V2bnQrMU1GT1JmOGlDTlNPRG9pM3hqSDdlVkhm?=
 =?utf-8?B?R1R5WTRFa1diQm1pdmZRYzlwSEdiaHpuWlFja09XR052VkpJc0Nybyt2aGZW?=
 =?utf-8?B?UWFqUFdQQjMvVERwU0E2WElvOEx4ajJiL2ZMQmRRdFpHalJza3ZncEduOWZK?=
 =?utf-8?B?V2UwdGhycjNaT1J0R1lLRlFoazJkcE1wcjNHdFBheEdrd2ZzRVk4RElQRXQ3?=
 =?utf-8?B?QksrLzhwYlhQa2ZqQzhQT3BkNE5rRnNpL1p4ejgrTWxOUDJLeWhhVHRyckJJ?=
 =?utf-8?B?K09HdUdab0d0YW1GcnBqbGFScWpBVTlFUHFKSGpiUDZjdnRhUWl0N0kxbndw?=
 =?utf-8?B?NlQ0SGRPTmlHRGpsMVNITTJUVHE4Zm1GenY2eDJsQTRta25MeXJVaDQvMUpi?=
 =?utf-8?B?dG1HNFY0ZkhRM25uTENPZmRSWXUyZytoa0pMTFFXR1g0Um4rTG41b2E4SzRI?=
 =?utf-8?B?UmxnNC9pd2lYTGs1Sm9TN3NQVE5DVTdlWTA0SjI2MkxMbDJMeHU5eFpIMXZm?=
 =?utf-8?B?Ritid1dXbTBVQS9CVTg5WGQxVlFsa0NlU3JPVUYvWnArWERWNjFNNk5KWXhT?=
 =?utf-8?B?VHVSYmw2R0c1SER5NC9hUlBicDl6TkFDSy9tVlpqUkx3SHR0R0RneTBUOFJF?=
 =?utf-8?B?RzdZV25XUlFlMThiOHZTRjNtNjRXcjZUMDVDdW5HTkVQV1YwcE1KR2F3OUxY?=
 =?utf-8?B?ZkNib091WXl3UE95MWpRVi9ySXFObnNwRXNPNm1KSUxtaGRRTG5KODEzTWhw?=
 =?utf-8?B?SFFXTHpyMlloUSs4TkVCdHlyZGI0TFZ3a0JPL3M2aFFHc1Nab0c2aEtLd2c5?=
 =?utf-8?B?YmMvU2FJYTIzOU54WGZ5KzNJMThKK3JaYzhrejd5NGVwY1VQbE4vRHIzalh3?=
 =?utf-8?B?L3dORTE2ekZBcjlRcWorZjhwaVEvSG1jRUFPYTVNT2ErZEZpNmhQL2loTHNE?=
 =?utf-8?B?dURsRUtzRHJ1WFhSMGRlU3JFMUVFK0VEQkZGdXZOQ3h1UnY2WkxsTFNHRXo3?=
 =?utf-8?Q?qZeHHxwXLdm6kuGgUbuwd4g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01CFFACBF80C9F41BB4C7DEF7B24A19B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5590.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0b4c8b-9350-46d8-25c0-08d9d531173e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 18:35:06.8448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ye9hQ0AIJO0vPrcMkjUPeGqznCRtacytFjgXReZ6oISumwWqhibJAzUWm5v1qiPMxc7G06aIkll4D3FoWMgRzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2848
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110100
X-Proofpoint-GUID: wcBffrtJzpbaH7wvaI7piiO-nu8HCFrj
X-Proofpoint-ORIG-GUID: wcBffrtJzpbaH7wvaI7piiO-nu8HCFrj
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTEgSmFuIDIwMjIsIGF0IDE3OjM5LCBIYWFrb24gQnVnZ2UgPGhhYWtvbi5idWdn
ZUBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IA0KPiANCj4+IE9uIDExIEphbiAyMDIyLCBhdCAx
NzozOCwgSGFha29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4gd3JvdGU6DQo+PiAN
Cj4+IA0KPj4gDQo+Pj4gT24gMTEgSmFuIDIwMjIsIGF0IDE3OjM1LCBIw6Vrb24gQnVnZ2UgPGhh
YWtvbi5idWdnZUBvcmFjbGUuY29tPiB3cm90ZToNCj4+PiANCj4+PiBJdCBpcyBub3QgbG9naWNh
bCB0byBjYWxsIGlib2VfcHJvY2Vzc19tYWQoKSB3aGVuIHRoZSBsaW5rLWxheWVyIGlzDQo+Pj4g
SW5maW5pYmFuZC4gTmV2ZXJ0aGVsZXNzLCB0aGUgY29tbWl0IG1lc3NhZ2UgaW4gY29tbWl0IDQz
YmZiOTcyOWVhOA0KPj4+ICgiSUIvbWx4NDogRml4IHVzZSBvZiBmbG93LWNvdW50ZXJzIGZvciBw
cm9jZXNzX21hZCIpIGV4cGxpY2l0bHkgc3RhdGUNCj4+PiB0aGF0IGlib2VfcHJvY2Vzc19tYWQo
KSBzaGFsbCBiZSBjYWxsZWQuDQo+Pj4gDQo+Pj4gV2l0aG91dCB0aGlzIGZpeCwgcmVhZGluZzoN
Cj4+IA0KPj4gIyBjYXQgL3N5cy9jbGFzcy9pbmZpbmliYW5kL21seDRfMC9wb3J0cy8yL2NvdW50
ZXJzX2V4dC9wb3J0X3htaXRfZGF0YV82NA0KPiANCj4gc2hvdWxkIHJlYWQ6DQo+IA0KPiAjIGNh
dCAvc3lzL2NsYXNzL2luZmluaWJhbmQvbWx4NF8xL3BvcnRzLzEvY291bnRlcnNfZXh0L3BvcnRf
eG1pdF9kYXRhXzY0DQoNClBsZWFzIGlnbm9yZSB0aGlzIFJGQywgYXMgaXQgaXMgcGxhaW4gd3Jv
bmcuIFNvcnJ5IGZvciB0aGUgbm9pc2UuDQoNCg0KVGh4cywgSMOla29uDQoNCj4gDQo+IA0KPj4g
DQo+PiAoc29ycnksIHRoaXMgbGluZSB3YXMgb2YgY291cnNlIHRha2VuIGFzIGNvbW1lbnQgYW5k
IHdhcyByZW1vdmVkKS4NCj4+IA0KPj4gDQo+PiBUaHhzLCBIw6Vrb24NCj4+IA0KPj4gDQo+Pj4g
DQo+Pj4geWllbGRzICJJbnZhbGlkIGFyZ3VtZW50Iiwgd2hlcmVhcyB3aXRoIHRoaXMgY29tbWl0
LCBzYWlkIGNvdW50ZXIgY2FuDQo+Pj4gYmUgcmVhZC4NCj4+PiANCj4+PiBQbGVhc2Ugbm90ZSB0
aGF0IG1seDRfMSBpcyBhIFZGLg0KPj4+IA0KPj4+IEZpeGVzOiA0M2JmYjk3MjllYTggKCJJQi9t
bHg0OiBGaXggdXNlIG9mIGZsb3ctY291bnRlcnMgZm9yIHByb2Nlc3NfbWFkIikNCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KPj4+IC0t
LQ0KPj4+IGRyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg0L21hZC5jIHwgNCArKy0tDQo+Pj4gMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+PiANCj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDQvbWFkLmMgYi9kcml2ZXJzL2lu
ZmluaWJhbmQvaHcvbWx4NC9tYWQuYw0KPj4+IGluZGV4IGQxM2VjYmQuLmNjODM3ODIgMTAwNjQ0
DQo+Pj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDQvbWFkLmMNCj4+PiArKysgYi9k
cml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NC9tYWQuYw0KPj4+IEBAIC05OTgsOCArOTk4LDggQEAg
aW50IG1seDRfaWJfcHJvY2Vzc19tYWQoc3RydWN0IGliX2RldmljZSAqaWJkZXYsIGludCBtYWRf
ZmxhZ3MsIHUzMiBwb3J0X251bSwNCj4+PiAJCSAgICAgKGluLT5tYWRfaGRyLmF0dHJfaWQgPT0g
SUJfUE1BX1BPUlRfQ09VTlRFUlMgfHwNCj4+PiAJCSAgICAgIGluLT5tYWRfaGRyLmF0dHJfaWQg
PT0gSUJfUE1BX1BPUlRfQ09VTlRFUlNfRVhUIHx8DQo+Pj4gCQkgICAgICBpbi0+bWFkX2hkci5h
dHRyX2lkID09IElCX1BNQV9DTEFTU19QT1JUX0lORk8pKSkNCj4+PiAtCQkJcmV0dXJuIGlib2Vf
cHJvY2Vzc19tYWQoaWJkZXYsIG1hZF9mbGFncywgcG9ydF9udW0sDQo+Pj4gLQkJCQkJCWluX3dj
LCBpbl9ncmgsIGluLCBvdXQpOw0KPj4+ICsJCQlyZXR1cm4gaWJfcHJvY2Vzc19tYWQoaWJkZXYs
IG1hZF9mbGFncywgcG9ydF9udW0sDQo+Pj4gKwkJCQkJICAgICAgaW5fd2MsIGluX2dyaCwgaW4s
IG91dCk7DQo+Pj4gDQo+Pj4gCQlyZXR1cm4gaWJfcHJvY2Vzc19tYWQoaWJkZXYsIG1hZF9mbGFn
cywgcG9ydF9udW0sIGluX3djLCBpbl9ncmgsDQo+Pj4gCQkJCSAgICAgIGluLCBvdXQpOw0KPj4+
IC0tIA0KPj4+IDEuOC4zLjENCg0K
