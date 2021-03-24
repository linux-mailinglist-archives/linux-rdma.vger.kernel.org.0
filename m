Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03003347AD0
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Mar 2021 15:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbhCXOe0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Mar 2021 10:34:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42582 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236243AbhCXOeV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Mar 2021 10:34:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OEYGeN005191;
        Wed, 24 Mar 2021 14:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=hHZB0vM9Hd1ylLFPw46Bt+ZQykp2hnsfFyupr0JrhZg=;
 b=EvNpqcbfyoMy20Std0TqeLYlAeqdVqV3oDj1nrofPWgyVZRohz2IWSjMmc3nLhumba3T
 S/72XUOj/i9RIUc+coipeAl7VpHTxd84YLIkxg6J328gs9ihbr6kTOiJPvCjn0G6VMfT
 Mci/VEn3ls8LCgrwHQo5riKIBM83nEaK7WlImwfaMow/l9r8CCj6GSiqDYtW+AU8mKGw
 RsOVUDHlun8kCHn2C5PsV+xdqyBoBymrBDbOOZfccVYH/1V9y/0KFuEFGJVIZ19nb8g7
 vSWkJ+zONZXDIA6zN9ro1rhGjugB/8GPuewmZRFDQMAjXgYagCOT2NFLJ3w+fbK0+ny0 fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37d9pn2vyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 14:34:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OEPCsv062143;
        Wed, 24 Mar 2021 14:34:15 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2040.outbound.protection.outlook.com [104.47.74.40])
        by aserp3030.oracle.com with ESMTP id 37dtmqw852-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 14:34:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQl8Kv9ZK8gqnQaRmkucX7lxm3mrUN1KROwRrP/JgmgnL6lqeniUKRdRKM/bEFdv4C0pTWD0MSeYRT1/dc/mAKGvcRXwadKdIZwOWiF9CNrdVnM+e7NUcU9AYibmN7WLJnzPOQNR6XORRhXWulCq9u8pBL5gx6+/kfO4P2pKZHKFlD46WJG0+LjlvuU8DJj7/Xi86qmyy/GPSy2WhDb6ogdSvDPMP5jDE8oYDCoWTSQENFiQ8J3m4DD/A0t/ysbmTvzgP0Q0Z7Jzb/box2csxbOsAUvQBB4lvpyCLU+PRj0cZxGAiXZwPiljzW/2xEY3wBu8On6dgUogSVf71RDbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHZB0vM9Hd1ylLFPw46Bt+ZQykp2hnsfFyupr0JrhZg=;
 b=MP6CrUQ8S15ERW54L0dJYeaj0YUyO7kK8YPxVz4D7YShk1eliuNzH0I8dtO9RFVdrF9nt320oOoYZQXOG5/mmWt+oFqI2Or2eJ8JYOXLSC6qxcsxlqza8iaRrZ74/NOhY26vdhJpPYjQy09XZGA8K3I9l62nRv1aVhfybywkMyyTzfGVj+Rd6n1VBc4EE8KsRQ4ApHSqGPtlrUcJ5Yzxjm1DZtuCPeQkdKsPHKcKxKCJfo3EAAZXfXePdhFSKJVb7dZKLWe/hRQMhUTsh0xUa1+O3+YXM3LOBXoITwp62N4QgygOdjfnrtmYTGa7TGBOtMU9c74TTV8+vZRB8prrZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHZB0vM9Hd1ylLFPw46Bt+ZQykp2hnsfFyupr0JrhZg=;
 b=ny4tZ0Zs6HFs9p7dPqtcCnv/mJkgko6iiLa6DODdlcBP8tBTZ9IonXW4mzzh1sKkSojuJl0QQeXgtgnRy9WG7qsBvai1kuG6JSsECKCOtQn87UoDRFMlOGng8X1Vtl4LcjUBB8ewdjGZ/AopFqSrHqZxBFOT6PBAnVdS5P4/vuE=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1254.namprd10.prod.outlook.com (2603:10b6:910:5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 14:34:13 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.3977.025; Wed, 24 Mar
 2021 14:34:13 +0000
From:   =?utf-8?B?SMOla29uIEJ1Z2dl?= <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] RDMA/core: Fix corrupted SL on passive side
Thread-Topic: [PATCH for-rc] RDMA/core: Fix corrupted SL on passive side
Thread-Index: AQHXHyBjcp8TyH1SzUWnxbuZ1f1Dr6qR/BUAgAE7LgA=
Date:   Wed, 24 Mar 2021 14:34:13 +0000
Message-ID: <BC10B8FD-30F4-44B4-957D-4A4F6A385BF9@oracle.com>
References: <1616420132-31005-1-git-send-email-haakon.bugge@oracle.com>
 <20210323194608.GO2356281@nvidia.com>
In-Reply-To: <20210323194608.GO2356281@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 768b8215-0357-4fb7-ae6d-08d8eed1e557
x-ms-traffictypediagnostic: CY4PR10MB1254:
x-microsoft-antispam-prvs: <CY4PR10MB125481C3CDA570D2F058789FFD639@CY4PR10MB1254.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O8UcMiIxgwfjOxdkiZKh+9pzHBEDItLEH6dTRsgunkmuG64FQ6zffwMEGkAdBQuqHSyARNfdaEuHu6U1GoCdq3hGXtkZ/LRdkeAO55INmezpaBCVSDKgGxAuHjKlD9kpXWPEjbOd1s9w8oG/5nV64yYqC4F2cEUM7ma4A07zPptW7HvTIm1texrQT5n8/W44Tvm3CxWtF0VVqwdNoRJYIU2VwFx5toSR8tDp1KlaQOEPaVLuJtecANZIjHx2EqQEdyXr0ZoJINXZj8cg8cQf47JE6R80IWSZPzO7krFYdbe4gJKZOAuFRxvAAosS3ePZeQsvWqRRYNPFuurNTDFhcN6A/Es6ZpsWyY5Aeh42rjPpHGPhLgF8dEXQ+a/Wl7Y+hflVB5eA5LmZZt+u9530v5Xjm0zn7Y5kdS+rkoZFXNdJ8rW5S7V68LnMKe/Uv+BnYn9pgK6QH7PUPa2bYg1BIam8fVSWzcknEJI6hJHRkdb0vr3JXzUygzZw5cnQzBhNNsUKyh3EhzxcKbQyrID+ibyVFXjQu/3pzKtho+hVH6tINNyZ+ftgW0beNXi3m7iDH3kjtsAccPvfNQixblwn0QpdgYIT7zVkHmKp83hDXtZ0QcvRjcAx0tZQgFw8YIztOWfLJhwsvjD5tsorAFYCKXCGM9xG4XAXGzNnIKZA1RSWKMr4ttIG21iyu6FRflhc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(366004)(346002)(6512007)(66574015)(66476007)(66946007)(38100700001)(76116006)(2906002)(54906003)(66446008)(64756008)(86362001)(83380400001)(66556008)(91956017)(53546011)(26005)(8936002)(316002)(186003)(6486002)(6506007)(85182001)(85202003)(8676002)(478600001)(6916009)(71200400001)(4326008)(2616005)(33656002)(5660300002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WnVGZVNMajdwTml4WWxyMlZ5OW00enp5TTAzNjJrQnIvVGQ1RUcxOXJQZ1Fu?=
 =?utf-8?B?aEdDK3QvWEZPTWtxRUhEVUdEOFFHUmJsOVFmQVhlc21XSmRvWmhCbG5qNyts?=
 =?utf-8?B?RFBVK0htMnNtR3ljbGk2SVVNb0pjazNFVERwMTVVQ0xoYjR3QXlxclFpV0Ur?=
 =?utf-8?B?b2NDUEtSdHB0UC9JUWl3NnEzbVVqMkI1amU2RENvNWFlUTJ3cGkvdFlkSmVP?=
 =?utf-8?B?RHBqOHhGdGhxOTlSUlUybEFDRjN2Zm5WOFI5TEd1K3FURldycnhYcnNyQ3hz?=
 =?utf-8?B?ZWcxV0VMcWJNd1pCRzY3WUtvamROUDV3OGxqTU9pU0crSkxMbGF3UUhSZ3FH?=
 =?utf-8?B?SUhSZVVPOXNUZldmTDVCb3J0RVNXaWpWK0FjSC81b0ZwYkRxMDVua2NydUtG?=
 =?utf-8?B?L2pZa0dMN3JwdXRDSElVb0FzN1RBRW81MjkyNVJvTnFRbEV4cldlcSt3a0t3?=
 =?utf-8?B?NjRPdEZXNytzQ0k0RDVFOHd2Q0g1TlFqVm5GUlZ4YmhGOWsrM1lqYXJ3ZGR6?=
 =?utf-8?B?aUg0eGFWdkZ5eGNGYzZKQmpiZkJrWU5RWGQ3bkZtY0twQ0pwUENwY3FHbVZS?=
 =?utf-8?B?d1JpYmk2dUUzaEx4bkJHQ3pxWHBjVzAyY1p5VGVEQTNuZEpvc0ZWQ0JRMnVr?=
 =?utf-8?B?aEkySVE4c3RuaituSmlPWEZKYVNMZnRTS0RrY0F0TEJmMUplYmFPcEF2UUcr?=
 =?utf-8?B?SU83NGhZdWJ2cldVeks4SkRIbExuVjBteTNIN1ZxNE0xMmYwYkhCQnpVMTNk?=
 =?utf-8?B?cGlreWFJSWRKa1llanF4ci9IV0NtOW9YdFM5Ri9SKytWdGUwRmcxeE1NVjBm?=
 =?utf-8?B?TmRIaFlwT2dPeGtvanRCNUZiRExFQWtGQ1QrTGw3T3krT1VhZ0Q2a0w5WTNW?=
 =?utf-8?B?WXdtbWFMZmZRR0krNVU3NlJtUWdhRWFWMGhDbng0RGx5bUpuZCsyMERHUHpu?=
 =?utf-8?B?cDMvUEloWGlKaVFxWS8ybGVMdDRWNC93cEF2WEJDSGQwaFNQQjVJWWJTOU8w?=
 =?utf-8?B?bzdUQlg5MXhTV01pbEQ5NVprRjVoQmNCdlAyUDVPVE53ZDB5Sk9jVkVET3dZ?=
 =?utf-8?B?L2dnQjYrVC9VZjRhdHQvNGxEb3NwMWkwSVExK29oV2xxMTdnSDc2WjVlU2dH?=
 =?utf-8?B?Rkw2SmlWaER0U0ozUlk2a0pjZUFqekljcE9nYnFob0F1OVU4YkxVcm0wLzlq?=
 =?utf-8?B?UXQ2N01yeDNEV2dieEloSi9DcmtzeGdhbUhVenRKY0JXN000bm0xd1pSVW9D?=
 =?utf-8?B?TzhTT2NHbHA3UFQrVTJWYXl1ZCtsODl1aDZVUFlFWUhMYUxMUFIrTlJHMUNE?=
 =?utf-8?B?VnJ3VE81YUVhSWU5Sk85MnJ3d3Y4dDRMZGNZL0tkRGFMYVgrcFFiRHU1WkIy?=
 =?utf-8?B?TkgrekFmUFhzbFQyWmlqRzFYRkNTbWErNkNOY2E4OWd6NEFLbGlFdHpvZ1pq?=
 =?utf-8?B?WW9NNHgvMG5DZmdMZjJOTW1UejdDTUZyb1V1cVgrckZsZlp0MWZFOGFTM0NK?=
 =?utf-8?B?bm9KMm0rcVZST3NRRUl5Q0JuZWtqRTF2dVd3ZXMxWUdHVkxEajY3b3V2S2hI?=
 =?utf-8?B?aHEzcWkybEpOSGVwYmtzbTZDQ1BBWWdXbUhEUjhsMGJ2eW9lMzZRY2xuSXZD?=
 =?utf-8?B?aXpmUnM4Zk81U0Uwbi9KckhoYUJsT0pHQlF2U0lITTN5MExwY0Y0b1h5MUY0?=
 =?utf-8?B?dnd4NWdlM2FBRXp4RXA1STYvYjNmVlNEYWxmUk52OGFIZVQ1M0dyNEI1R0NO?=
 =?utf-8?B?QlNOaVZxUEVTTlU4TGFkMGI4M09iTWNycHhWaDFaYkp4bTM3UU9nbnIwUEEr?=
 =?utf-8?B?MnRYWHg2a1BQcUp3YXpUUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <714AE10142ACD0499EC1CBD8B81B2620@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768b8215-0357-4fb7-ae6d-08d8eed1e557
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 14:34:13.5579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dC8xPB6R88GeEomoKEzMke9R1j9AiPUKRkXingBcazyVFHzMqMsKRTnY4i87/ctI811oKuhgjfldxKT1N6vZkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1254
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240111
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240112
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjMgTWFyIDIwMjEsIGF0IDIwOjQ2LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgTWFyIDIyLCAyMDIxIGF0IDAyOjM1OjMyUE0g
KzAxMDAsIEjDpWtvbiBCdWdnZSB3cm90ZToNCj4+IE9uIFJvQ0Ugc3lzdGVtcywgYSBDTSBSRVEg
Y29udGFpbnMgYSBQcmltYXJ5IEhvcCBMaW1pdCA+IDEgYW5kIFByaW1hcnkNCj4+IFN1Ym5ldCBM
b2NhbCBpcyB6ZXJvLg0KPj4gDQo+PiBJbiBjbV9yZXFfaGFuZGxlcigpLCB0aGUgY21fcHJvY2Vz
c19yb3V0ZWRfcmVxKCkgZnVuY3Rpb24gaXMNCj4+IGNhbGxlZC4gU2luY2UgdGhlIFByaW1hcnkg
U3VibmV0IExvY2FsIHZhbHVlIGlzIHplcm8gaW4gdGhlIHJlcXVlc3QsDQo+PiBhbmQgc2luY2Ug
dGhpcyBpcyBSb0NFIChQcmltYXJ5IExvY2FsIExJRCBpcyBwZXJtaXNzaXZlKSwgdGhlDQo+PiBm
b2xsb3dpbmcgc3RhdGVtZW50IHdpbGwgYmUgZXhlY3V0ZWQ6DQo+PiANCj4+ICAgICAgSUJBX1NF
VChDTV9SRVFfUFJJTUFSWV9TTCwgcmVxX21zZywgd2MtPnNsKTsNCj4+IA0KPj4gVGhpcyBjb3Jy
dXB0cyBTTCBpbiByZXFfbXNnIGlmIGl0IHdhcyBkaWZmZXJlbnQgZnJvbSB6ZXJvLiBJbiBvdGhl
cg0KPj4gd29yZHMsIGEgcmVxdWVzdCB0byBzZXR1cCBhIGNvbm5lY3Rpb24gdXNpbmcgYW4gU0wg
IT0gemVybywgd2lsbCBub3QNCj4+IGJlIGhvbm9yZWQsIGFuZCBhIGNvbm5lY3Rpb24gdXNpbmcg
U0wgemVybyB3aWxsIGJlIGNyZWF0ZWQgaW5zdGVhZC4NCj4+IA0KPj4gRml4ZWQgYnkgbm90IGNh
bGxpbmcgY21fcHJvY2Vzc19yb3V0ZWRfcmVxKCkgb24gUm9DRSBzeXN0ZW1zLg0KPj4gDQo+PiBG
aXhlczogMzk3MWM5ZjZkYmYyICgiSUIvY206IEFkZCBpbnRlcmltIHN1cHBvcnQgZm9yIHJvdXRl
ZCBwYXRocyIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBv
cmFjbGUuY29tPg0KPj4gZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY20uYyB8IDMgKystDQo+PiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+PiANCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbS5jIGIvZHJpdmVycy9pbmZpbmli
YW5kL2NvcmUvY20uYw0KPj4gaW5kZXggM2QxOTRiYi4uNmFkYmFlYSAxMDA2NDQNCj4+ICsrKyBi
L2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtLmMNCj4+IEBAIC0yMTM4LDcgKzIxMzgsOCBAQCBz
dGF0aWMgaW50IGNtX3JlcV9oYW5kbGVyKHN0cnVjdCBjbV93b3JrICp3b3JrKQ0KPj4gCQlnb3Rv
IGRlc3Ryb3k7DQo+PiAJfQ0KPj4gDQo+PiAtCWNtX3Byb2Nlc3Nfcm91dGVkX3JlcShyZXFfbXNn
LCB3b3JrLT5tYWRfcmVjdl93Yy0+d2MpOw0KPj4gKwlpZiAoY21faWRfcHJpdi0+YXYuYWhfYXR0
ci50eXBlICE9IFJETUFfQUhfQVRUUl9UWVBFX1JPQ0UpDQo+PiArCQljbV9wcm9jZXNzX3JvdXRl
ZF9yZXEocmVxX21zZywgd29yay0+bWFkX3JlY3Zfd2MtPndjKTsNCj4gDQo+IHdoeSB1c2UgYWhf
YXR0ci50eXBlIHdoZW4gYSBmZXcgbGluZXMgYmVsb3cgd2UgaGF2ZToNCj4gDQo+IAlpZiAoZ2lk
X2F0dHIgJiYNCj4gCSAgICByZG1hX3Byb3RvY29sX3JvY2Uod29yay0+cG9ydC0+Y21fZGV2LT5p
Yl9kZXZpY2UsDQo+IAkJCSAgICAgICB3b3JrLT5wb3J0LT5wb3J0X251bSkpIHsNCj4gDQo+ID8N
Cj4gDQo+IEkgc3VzcGVjdCB5b3UgY2FuIGp1c3QgbW92ZSB0aGlzIGludG8gdGhlIGVsc2U/DQoN
CkkgY2FuIGNvdW50ZXIgdGhhdCBieSBzYXlpbmcgYWhfYXR0ci50eXBlIGlzIHVzZWQgfjEwIGxp
bmVzIGZ1cnRoZXIgZG93biBpbiB0aGUgY29uZGl0aW9uYWwgY2FsbCB0byBzYV9wYXRoX3NldF9k
bWFjKCkgOy0pDQoNCg0KRnVydGhlciwgaW4NCg0KPiAJaWYgKGdpZF9hdHRyICYmDQo+IAkgICAg
cmRtYV9wcm90b2NvbF9yb2NlKHdvcmstPnBvcnQtPmNtX2Rldi0+aWJfZGV2aWNlLA0KPiAJCQkg
ICAgICAgd29yay0+cG9ydC0+cG9ydF9udW0pKSB7DQoNCkkgY2Fubm90IHJlYWxseSBzZWUgaG93
IGdpZF9hdHRyIGNvdWxkIGJlIG51bGwuIElmIGliX2luaXRfYWhfYXR0cl9mcm9tX3djKCkgc3Vj
Y2VlZHMsIGl0IGlzIHNldCBhZnRlciB0aGUgY2FsbCB0byBjbV9pbml0X2F2X2Zvcl9yZXNwb25z
ZSgpIGFib3ZlLiBNYXkgYmUgdXNpbmcgYWhfYXR0ci50eXBlIGluIHRoaXMgdGVzdCBpbnN0ZWFk
LCBmb3IgdW5pZm9ybWl0eSBhbmQgcmVhZGFiaWxpdHk/DQoNCkkgaGF2ZSBubyBzdHJvbmcgb3Bp
bmlvbi4NCg0KTGV0IG1lIGtub3cgeW91ciBwcmVmZXJlbmNlLg0KDQoNClRoeHMsIEjDpWtvbg0K
DQo=
