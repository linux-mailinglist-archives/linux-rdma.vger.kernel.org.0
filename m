Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DA745929C
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 17:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhKVQG2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 11:06:28 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18580 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229955AbhKVQG2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Nov 2021 11:06:28 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMFtVQ7024917;
        Mon, 22 Nov 2021 16:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=scrg0rSG9ddCbEXXormY1R0AVl+tG8VtKsBgcFwNIaE=;
 b=c+YtGDUunZ3BlMxL8eJNbVi9o2/fEMRMMq33TJEoPvUOyHVkElrl3GBkzRoBblzL2Xhs
 ddEamfWcTpCVbvi5A6hSuBwKXN603d1CUyy37TRWuFKp2p5TVIiOSMIdI0C1VVorB0EI
 WyPsGKqgRBn8I814nDtUlx6oR2veeaB4B2VqnnMwQqedWX03DONJdXHhCbktuuhCZ7fc
 kVcge6M2UVp32qTVbzEXZtEXeNeSXVMlB+nqQkUijDMbL95hqokdYsZsknwd3oqrbEuP
 wLwzKwgwvzCYWOqIE0AIooIpLgJOjIL1S4k7p5STGe6eTovVJssP9BW6oSGOTud0P0/h 9g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg69mat35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 16:03:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AMFtNm6137817;
        Mon, 22 Nov 2021 16:03:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3020.oracle.com with ESMTP id 3cfasqwb3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Nov 2021 16:03:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2jnsd8Nf6bHL1uPbN6sh+uiohq2rcNZopxvrMykbMXZBa+pFYT1dVk+UQOEMEa7uQAZUTTviZ10l50q2CXgiHrkHXiTVYk3aDakGob2i4e7+GzVhwO0PtoWJlCpKCB5C2GVoQWW7n2jeM4krfj5qH1g1B3ECdpdf/IAuiQnodtdaR68c7yKabEfodvVrLbIxb1V5tgd+iZQDwf2gHc01QgBwSwPsG+MOYr4tC8asvNcu+kzOJ1XkqedY1NHaSQVQkYLnEigwmqxBJWJVH1kMykR3vm7OXBHPga0WlBEimiSE5qcz3zOuGa8feeNTUdNx63wsmY8DrU7d8zjVuQFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scrg0rSG9ddCbEXXormY1R0AVl+tG8VtKsBgcFwNIaE=;
 b=esMbKC0Bi9VwaVFdWXmx6A9uidweolJobIwEDMY1c3drgV3RYBB8a2qJsDbgnuyzEuBsmRqeXpyhHhhCrWI7NyYhg9dxlJ6ZWrmVHF7SVYpc9hg8B5lcH56qFNpThKZxofpCPXAxGESuw6COFj+Qt9BvusyZi92ULh5/wVWxg4dZ5YRY3+7LCOmmasUI0TFLPw4WZLuXdhGM737PAgNmsFxjVZTeUUtt25cEKYrHy5OJiIv/Kme+VqqeM8WpIccLgNV4moFNi+hOjevGQN/VbaayzZVV7MGaushm1vuniuO5jLWONCQby0IQ1CBa6jNcvAj8ysUrYKcLaBi/tQj11A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scrg0rSG9ddCbEXXormY1R0AVl+tG8VtKsBgcFwNIaE=;
 b=mIX2ARS1Y3C8MjE5gRB3JDqktSYLT6tn524Nv4e2rEqj5yXzlD217lDDnIryjJJ2OEbcFgpXGaoZN19diTZJu4tuAgDqBIWtPzJV/J/QQoOnYgtPC338RjYo2oRjbUukR45soaoJR4p4mrYobWQkeXyRoggx6uqDaQmCzi/67+4=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by PH0PR10MB4743.namprd10.prod.outlook.com (2603:10b6:510:3e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 16:03:02 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::70e5:d105:dd10:78e8]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::70e5:d105:dd10:78e8%7]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 16:03:02 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: Two announcements
Thread-Topic: Two announcements
Thread-Index: AQHX3L7mWSPp5lyhZEaAy3lkRa/Xa6wNscYAgAIJlYA=
Date:   Mon, 22 Nov 2021 16:03:02 +0000
Message-ID: <E78017FC-7128-41EC-9275-0753E7721792@oracle.com>
References: <CAGbH50sEwKeB3bH6XHm+C1R_giN85pi6Bqq4fk-rFq-iU3bavg@mail.gmail.com>
 <YZoJrPGtQJ9e3v9K@unreal>
In-Reply-To: <YZoJrPGtQJ9e3v9K@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86c096b5-d7c4-497b-9e02-08d9add18fd1
x-ms-traffictypediagnostic: PH0PR10MB4743:
x-microsoft-antispam-prvs: <PH0PR10MB474336FA53027430265AD16DFD9F9@PH0PR10MB4743.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GoNWopDkhDCuLZJ5Fyp57zfroZfLuWpDt4Bl0bsw7lZlbgRscOHwF3Yi8eQeYW89Y/EUBKx5NR/FdTtFiRCvgDf77azy404DZpZcuxPkuZd2t1Wx8LOtLW/7GDKDBBuHj/HEKNIWkvzqJ/1GwrYAAbtdNRwPbRnIwTtKWqN7XWGWhNkrn9gcpoRiy74/6paN1lWnYGUPyQFFjw3hUtPdFeltdsEEnApP8q+VC2B/U+h7UWAYWUqtMk+haSbFZBQTPD1rLwLfxXgafwwTYXo0wZlsW6zfnzrJPf9Acf7ysiLLkiQJmTNIq2fm2EMsFyWZULdIAqfNYdnQNbjH8PfV+l6IVyob9abMlEvYDmiBq+IEyZBvmr9wuNzwq653YhB4YPc746VI1woOvzcDvEjrigt78jJgD4vwkKx5qjBzvQZiNMN4AnQdBwOWlvNLpN4jTXAUS/0JYIEIBDw2mlWb4n+ffsV8DHCCBFez8WGGWLAKeQJ2XQD6dYtWUy7CU88ZOCJgq2X8N8v5qHCI21ahn0epv9p6q2tnS979IViH4wfrb5adAN4Hj/gMPfxgUkq2KvBhUEVJV2zOLvbCaT7SE20tKk377PIcBo5+CF5dKhotmo1nkKBpUEdrjnmWVfDJ23uo0xu1CwWBGfVqUFzoAoA0lLSKPcpHa8+CDibDPt9jbaGnW9kVjtjxpJOgskr/+cQsfbeKMBKgu4eBmNA0xxXt0gQ4t4UhsEEFXp4aa9Ed9mmo73Zz61NGN7fhdQpw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(76116006)(66946007)(33656002)(8676002)(2616005)(91956017)(8936002)(36756003)(66556008)(66476007)(6916009)(66446008)(64756008)(86362001)(54906003)(2906002)(38070700005)(508600001)(71200400001)(53546011)(6506007)(7116003)(4326008)(6512007)(5660300002)(3480700007)(4744005)(6486002)(44832011)(26005)(122000001)(38100700002)(316002)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1NZejVibkRnSk54eEtUMlA5OTA2UXZ5TlREbVNMYWd6SlpJcEZqeXpnMEYy?=
 =?utf-8?B?QzBsVFRBa28veS9ZanNuZEg0eUF4Ty9oMnl0S1EyaGcyVWh1cVlTUitrTmV0?=
 =?utf-8?B?bTZsUXhTdkx2VTVtOWdNWjB6b2RpR0NHUENiZ2ZHWXlzNENKV0dIenRVLzZL?=
 =?utf-8?B?ditXeTl3ZTFQd3VnZ1FtdFJZb3hseWdCajdFRVFCQzM5ZUxKN1pBb3NSRW5y?=
 =?utf-8?B?UUxrdk5sK0MrckNLUTJJUjNQTFM3Y3FMZCtqQ2lXd2duVDJRc3ZkMUlvRDZi?=
 =?utf-8?B?ZjI2Nnc4UzZaSmlZUFo4VktHY3VhRjIxYnlUZFNXV28rY1laZ2p3ZlNuL3NF?=
 =?utf-8?B?K05jdm94blZjc2FHU25JZ014NXZpallibURyditLUXowVi9zSmJxV2FweTQv?=
 =?utf-8?B?VDZvRzBlRlJYR3FwUzZHSHMvSTZsOEw1eEM2UVJVdStJSTBzcDQ1d1dKRzBw?=
 =?utf-8?B?b1BCWGUrWlRwcCs0Q3d6cjU2S2ZqYklhNnF0UnRuN2l3aEhPQS9wdjNLckJC?=
 =?utf-8?B?L1ZrSXg0UzZBczJkTDdtYTlCczJtMGlpbWVhUzRTVjJLMG9tRXZmWXlHbWdt?=
 =?utf-8?B?a2h2U3FFckM3VTMxQStjNFNCaVQyOFg3WFdQb3ZpK1JyVjFDQVp5WFZmS0Zw?=
 =?utf-8?B?aG9PbE5LNEt5RGJ4K043eDhTTEFiQU9WYWsvVlhLam5PaUFHaVBPK3NRNFBy?=
 =?utf-8?B?ZzMzVkhHU1czUnRWVGlVUFdkb2Z0c2hpaFh1bWlLSlRIbncrNnlhOERMZGhL?=
 =?utf-8?B?V0JRYVNRRHptclFORWJhNjRiN09SR2Q0Y251WHNmTFpxZTA1U2NlWDJRNVUz?=
 =?utf-8?B?Z0hxdXpjWURFRFdud1JaU3ZNc0E4WDg3YlYyQU4zNjNwZWFqUWM2Rm9tQmI0?=
 =?utf-8?B?T2g3dXVXaHA5d0FKZnNLK1U0SDJyaVAvdFF4UlB0VGRlZlp5NXFCb3Z0aTJ1?=
 =?utf-8?B?bGd1TDIvRUF2cFZoVFIwb3IzTkd0UW1Kc21LUFltc28vTHVpandqMVhKSWk3?=
 =?utf-8?B?UzA5VkxaaFhVNThLblhzZExnMjljbkpvOGgrU29YYUdMdFJqTUNmQXRqLysr?=
 =?utf-8?B?dncvUDRuU29TOTJzRmlXSy9zT0N4dWU4RGZFNXhPYnpxTTBKMjF4NGZzWW1v?=
 =?utf-8?B?MHZKMnAzWmlmcjc4Q0hydngwdE9sVWZpMDZqeG44aXgzVnlQRFR4UXppc0pG?=
 =?utf-8?B?RU5GRGVkRWZDSXdQajAxaWkzaUordCs0SFk5YU5yV0hFZno3ZUJNazVPb01p?=
 =?utf-8?B?NE9tK2l0dkdJT0wwYmh4Q3pHK2lkaDgyeXpjY0FhUWpUU1M5UUtyelNkTnBX?=
 =?utf-8?B?cXQ3NC9zUkZqelJoV0RaMkRTYzREOXZLR0twOFRjOHMvcXZvY3Y5VVQ5N1FO?=
 =?utf-8?B?YlFhbm84aXJKR2RGMUt5YURRTWxDMFRDakZ4UnVsWUlsRW9zVE1RYXJvVlNl?=
 =?utf-8?B?MG9IdzVlR2dVeWwvYnNGSEtvMTIzL3M0MEt6bldDZ2tTUGVzMS9JU3QyQzZC?=
 =?utf-8?B?ajdaMlNEUEJ0d2s0bE5HaUFORjZSQm9PN3JzLytDSm56aVNyN3lKSHZRakdo?=
 =?utf-8?B?dFhPTkl0TWN0TGZ6TTRFMTVHYVVmQVZvT05yVXVDM1RPd0VwQ2lmdVRSYnd1?=
 =?utf-8?B?TDBKTUhHei90TDhpTEhkb2ZoT2NEUUd6c1pOenRWOHpKUHNOcE4yTGtJdngv?=
 =?utf-8?B?alFlcWlOVlJsZ3EvWlp6YTQ3dFM0a0hQNmY0cDM4VVJtSGVWbDhNTU5iUVlj?=
 =?utf-8?B?dTc1Y1BXWnJwYkxFTTNBWnhWbHZKdjlqb0c3Q0NxV0tMTjREMGpLN3JNdEV0?=
 =?utf-8?B?ejZQOGcrc1doNVk0emZrMTczWjRHOGtnd01TcWNEU3FhdDIwUDR3NGJwQ01M?=
 =?utf-8?B?TklyTWRKNllhbCtVS0VxUG9yTVlFeU9lYmVnTkNQU2dMWExuejFmWjBIMDM0?=
 =?utf-8?B?UFJDeUNVWWJNUWRYYjlLUy9pMHUvY0JqQXYwc2MwRnFtT05zeHdjUWNNOHVQ?=
 =?utf-8?B?WTM5YVNtcFpIblI5SkdKdzlaOTRsTGlYdS8wTDAxWi82NFViOE1rakg2WTc3?=
 =?utf-8?B?NmdMNG5TQjMrQUpGKy9Pc2tkbkxrZTh0K3hYMlpROXlQYmgvVWYzeGxrV2h0?=
 =?utf-8?B?RWR4UHBWR214d0RSZG1ZcCtZWXA3MHNCdWRycklrUFhsY2J6cUJoM0FPNzdT?=
 =?utf-8?Q?/MuIjSkqY4hKhFeD5W+Pc+M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <510BDF6D91164B4E8590F5AE822E9493@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c096b5-d7c4-497b-9e02-08d9add18fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 16:03:02.1608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TT6tQa7yXGtLgBVXOUPnIBoebrxVKM97wv3zal6Qgb5yEEFrR2THhye4UEzhLa3GoPN83iPFY/sGVLq/vTUcrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4743
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10176 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=923
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111220082
X-Proofpoint-GUID: kXjMWiCmBeOxUUr9J614s5LiNtW9sgpm
X-Proofpoint-ORIG-GUID: kXjMWiCmBeOxUUr9J614s5LiNtW9sgpm
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjEgTm92IDIwMjEsIGF0IDA5OjU2LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIE5vdiAxOCwgMjAyMSBhdCAwMjo1NzowOVBN
IC0wNjAwLCBEb3VnIExlZGZvcmQgd3JvdGU6DQo+PiBGaXJzdCwgbWFueSBvZiB1cyBoYXZlIHRh
bGtlZCBpbiB0aGUgcGFzdCBhYm91dCB0aGUgYmVuZWZpdCBkZWRpY2F0ZWQNCj4gDQo+IDwuLi4+
DQo+IA0KPiBUaGFuayB5b3UgRG91ZyBmb3IgeW91ciBkZWRpY2F0ZWQgd29yayBhbGwgdGhlc2Ug
eWVhcnMuDQoNCisxDQoNCg0KVGh4cywgSMOla29uDQoNCj4gDQo+PiANCj4+IC0tIA0KPj4gRG91
ZyBMZWRmb3JkIDxkbGVkZm9yZEByZWRoYXQuY29tPg0KPj4gR1BHIEtleUlEOiBCODI2QTMzMzBF
NTcyRkREDQo+PiBLZXkgZmluZ2VycHJpbnQgPSBBRTZCIDFCREEgMTIyQiAyM0I0IDI2NUIgIDEy
NzQgQjgyNiBBMzMzIDBFNTcgMkZERA0KPj4gDQoNCg==
