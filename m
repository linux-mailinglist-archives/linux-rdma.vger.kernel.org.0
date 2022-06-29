Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D274560DAF
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jun 2022 01:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiF2XmA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jun 2022 19:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiF2Xl7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jun 2022 19:41:59 -0400
X-Greylist: delayed 3444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Jun 2022 16:41:58 PDT
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58506659E
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jun 2022 16:41:58 -0700 (PDT)
Received: from pps.filterd (m0272704.ppops.net [127.0.0.1])
        by mx0b-00007101.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TLYerw028582
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jun 2022 22:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=campusrelays;
 bh=gegLOxmB7JKAvFBdK7MNNw9uA3luddNJ8i7Os+0ydXk=;
 b=NCNDePicIED5ETNn2Ujjj6VrxAGB0STVgGIoXPVpSf4I7wAwOORTXcqMDjBViuWRT95C
 CGB+cY2YCkpr8GkXe4DIByPEenMaBt3x9MN+zOZJDOoXBRC+9xG9TW5hkNeNXWC+WhI8
 lY92sOZLwvG5T34d60S83o1X4l39wvKYMzm7sDZxAuBGfGFNiSen+8i8qpDvTsdmTi3u
 pBnh7pszGgbCRNT6TGFdbbJzGFEhbA/+JGFxSqaXrowX9lWaWI91qrTR0iLcNu63QF71
 ruEtkrnLpcTonm5xs6hhpBC4ZPXKvZnWtkq/E4kTcXg+pMbdqlWNe7jHYD/92Mh54foi Yw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3h0qb45rxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jun 2022 22:44:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nK3ahO+wARiuADZSrb/0C0RdpTTsxYWVxReAkF/qBnJkEMwFzSUZsvsQvF7MJ8GInEsMIgm3Z+jk4kZXHjE3d+GGAVKNkw4EaIRnV00cBuCDmJGn+uBT83dfWTNC/XuRpGE5XRVzmMpoJ4Ukjy1wHVKl1XtTnOtcfWNwe3Q6IMSevdrRO15SPBT/0sqc7nL8xdSoTGyAMbk3Ede2LOlcLb5bCTYHEDPVBXOAvKoMPhQKlm0Aw+aMLmJ8a72opVd63luNaHN/eOVLPvQkn9E/Z/7fXtd7aisCvpU+/SBDdm7sF7aAIkshyZ0mHIC7AKL4kXMs3Fa3Tl2K7Lx5wKK+mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gegLOxmB7JKAvFBdK7MNNw9uA3luddNJ8i7Os+0ydXk=;
 b=GnXNy8flEetM/WZxjLFazEXRIRfpZ+qOrjAiGC7/graV4FaQRLJ7MLtHdnaJytPMHpWmbsw9Gfvndnw0ktjghxxh3lvQ2xJCcoHwDf7pSL5FPN8r8kO7jPvD9pp5UeOluVw7dTIHo3giF6qz5Hcict0GLRrvC81wc25aaNQxeep75DJg59C94IyXeM783EG3YjC6U+800lBevXzyHV7LziLThcnQG4KPtM9uOx+/raJLmmkL87uakCXe6JR3nKQO7M/yPV6D9dZPb6H46bID9RwjT9dBeN+1YUNx13TosLJQykRjS4Q7BeuuHON2Hs7zi4nPPPLT+CY83KTuhL8FDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DM5PR11MB1962.namprd11.prod.outlook.com (2603:10b6:3:10c::15)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 22:44:31 +0000
Received: from DM5PR11MB1962.namprd11.prod.outlook.com
 ([fe80::e4d4:872:b02c:3457]) by DM5PR11MB1962.namprd11.prod.outlook.com
 ([fe80::e4d4:872:b02c:3457%12]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 22:44:31 +0000
From:   "Mor, Omri" <omrimor2@illinois.edu>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: mempolicy ignored during ODP faults
Thread-Topic: mempolicy ignored during ODP faults
Thread-Index: AQHYjAnMoGyy/+SXGkO6kinhjNUeUA==
Date:   Wed, 29 Jun 2022 22:44:31 +0000
Message-ID: <972B9445-5142-4482-A50C-E2C82B27FA36@illinois.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d69b2c4-cea1-4388-691f-08da5a20eed2
x-ms-traffictypediagnostic: MW4PR11MB5892:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jcLTbl2XTRuQxEFsq+M69PnGwJGcTUTL1g96euUBeZIg15JDLZ9ihztuMNiwtZBfrPJQSXWM2gFtM8kU9zSvlS+VVJb7ia7Pj9g/NJBS30MYPn4QXooAyrSBmdWv73B4o5gu1v2yoXlB23hGO4qv6boaOwjObhziNsmbYKGpSWGlTeaIU5a6IZlbnRasnKMR5azgahhBi82H/ORS/8X8ORHq3qRu8Hd4eBKyFBXcVYrbMZ2/Cafeo3+FcVKoxmKQO0SUs8pN565PV5oDJH8zjD1aaIMC3V9wzOA15zxMv9+0FmZYP3oNzFfUlIl7uO4qmxwkt7ODyXPu9jI6x/GtPeBGc7VOn4/lV7rcKsReYVtLbERpOCYbaRKf/Kf4euMdU+HdsqKT949Va2s1ZgNrwtHRFuOb51QDPE7QtMqqLDKx/qns8iqExXmYLj4IAADVs0R54c0FCvqYnqYLoNtWDnv6tfx1Zfo7Al3fz6dQ0EslhKlp9jHZVKqN0i0q7IZmXqLu4insClG8rT5/MKYOL7QV39HZZqbjlzA9nxie+OtG4GAE8ISrKm6Atn7oqeyaqk26kCHZPKLt0AQbkSfe8TtvwPrSKzVPqncIy2KdHmbYW8GC6+Pxxh9QEwHLYvQnipoDly4Zaktu9X14I7u3ACv/NNIPqUix+RnIdnDwlAOuuHvSq6ANNVlyY8hwq0y4pgRbm+gSZQOogMhvoEBd1c+01EGfXKbF2kc+fJzJKx2jztUSDwZtcrWO4X6VErGgUyhPxbdcFKtLH8APiUzM0LLjX3XoDEv9HzbWRjsxHVmgtZ1qGmJFNZNSbeoHU3ik
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1962.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(8676002)(66556008)(66946007)(66476007)(64756008)(66446008)(76116006)(86362001)(8936002)(91956017)(41300700001)(122000001)(2906002)(6486002)(38070700005)(6916009)(71200400001)(75432002)(478600001)(26005)(186003)(6512007)(36756003)(316002)(786003)(41320700001)(2616005)(83380400001)(5660300002)(6506007)(38100700002)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmhXTm9naTBHbkxNcEZUZUhJbEdpb3dYZE9kUDM0MkIxVGVRMGVqT0NDUEZL?=
 =?utf-8?B?MDB1cElmWnAxZVNNWmtOT3NpRXVVUDhQR3dvaVhkMmtTT2xzQWdQdDlHcU1J?=
 =?utf-8?B?c0NPbjlyRjFCTE0zdVRFY2VDV2cyTUp5dVdKMXh4YlE1b00raVkxUTJ1Zzd5?=
 =?utf-8?B?a2JEQTJEakkzTFFWeXhCS3BwVFNXdkhhRjFxb0JmcGQ0VXNyenZVVUthS2N1?=
 =?utf-8?B?V1ExZ2tWampVOGhPOWxUazk4Mk9ydTFoaGJJQzVybXROa2JNNnJSRTJIY0t6?=
 =?utf-8?B?REpVYTNMNEZLUGorWHpxYk94VmZmcGlBWmxHNEFTUTNSamVVdHBGVG0veFVI?=
 =?utf-8?B?TTA1UFhlSWkrSHFieEVFaVBZZ0dPL0RidVVaVm04NFhkQTlER1BIZnE0TWVq?=
 =?utf-8?B?bEFZblprSzlPM2NSTVcvUy92Z0ZQdHI0RFFCeER1emt2SUxXMzhFUCtGeWFJ?=
 =?utf-8?B?bmhNWUgvMDd1MzlDTEF5U3BrREF3L2VURWdlZ0pYcER6c0VSYWlnUzhWVTlW?=
 =?utf-8?B?N25vM1hqREZPVjFMak9QL0dXeStnQkRCZ3lENlRaNWk4OXdRT3ZNZ3dVQ2FW?=
 =?utf-8?B?T3JDMkkwcnRWTjVzRHQ5cnVzQ2ZsN0Y4b1FQTmI5djFwWGtWcXZkTDhqMlkw?=
 =?utf-8?B?MVJTS0JqR2lDTWV2enFzVWhqaHl3aW5QTHhIcko1MTJncUhMQVVGdUZRWlEz?=
 =?utf-8?B?UVVCOGl5WmVJNkQ0eHNidWpRdHVEdGZmOUVuSXFtOHkwQmJ2WEtGaC9jcis5?=
 =?utf-8?B?UndmelpjMllEMlkrQkladkUvbUdxYnpTV0huTk8yZG1YRmN5N0FOSFAwSjgx?=
 =?utf-8?B?Y3lpZkx0RG9pb0xpZktxcU1qVldyZnBVMGUvVGlNWVNrbUt6ZWgzQzJRSFRJ?=
 =?utf-8?B?d2VDVjR1S3I3SWVnREJaNWFiU3dITE9hVVBKYzFkU3ZWQkIrUUY2Yjk3VVJz?=
 =?utf-8?B?ZHFxTFpYYXU5eW5BVlRubVlhaGErRkdXZllBZUcxaG9sTDFEMVJydUliUDU5?=
 =?utf-8?B?cmF0NjdvV1U3NWF1OUNWQXd2TGU2Sk50SEplOXJpclpzV0ZNOElYTmFiSWRr?=
 =?utf-8?B?NmtpaFhGOXhXTGtjVlBlT0F3dE43eHY4QXRYVW9aQnhKWi8zUm9YTWxYOVFN?=
 =?utf-8?B?bkFlWW92RlVIbnJiUTFxaU8wWTJhVHdNaUJ2Nm5UREt1ajBqaENhUXhNSjAw?=
 =?utf-8?B?ZTJJYjRnbmFhalBjNnppVTJrVU9Idk85U3FxWk1oWVRZUUxsMXZLcENaVS9z?=
 =?utf-8?B?T1BrU0VrY1JIc3JFdkJkNlgyczlTb3pQeFlmUUlQVis1Y1ZrNzFKZ3BxL3V1?=
 =?utf-8?B?aVZObkhUbjh2dHFlT2dGQ3Z1ZmNYV25HKzUzSXdXZ2xkMi9OVXhHWU9UallD?=
 =?utf-8?B?QmdWWndkMSsxUUtZRXZwWjBQYzdleVprSVdUTnROWGJlNDNqYk9EOGt0OHNN?=
 =?utf-8?B?RlZFZmltdG91Ty9IY2tLekZsUi8zMmpXRDdSTlZ3Z0RKdS9iUE96QUxwNS9o?=
 =?utf-8?B?YnNQaitPelN1czg5bUFCRkZoYjBmNFBpZndDVXp0ZXhVZUJkUlhFWWJpRGVn?=
 =?utf-8?B?dzZFSGwvcDBtcWZsKzBkeGk4VzZBR05QQ25kTFF6SHJhbktyQVYzZXNQaWla?=
 =?utf-8?B?aXMyZ3FLSncxZ3gvd0tNcm42RURRUnVJSWp1MldDeXZxOXNMc3FIZ0ZxM1Vm?=
 =?utf-8?B?YkpSdWhGUlRucE1DQlVvZEtSRytjVjRQMFBrQjlMVjFlSlZ1WWFNcVRPMUg3?=
 =?utf-8?B?SEJqdWZYakF5bnJOUW9jM3RBVFFYZ2pTSHV3bGgxYmtIaXl3ZXhuRVZrYktB?=
 =?utf-8?B?aWt2eitoUnMrUnl6RTNpOE1sdDFHZmpodHAzT3NZa09ibFI1d21ab0VSQldD?=
 =?utf-8?B?Z1cwRjNEZjFXd0kwNXVjNmN2ZjMvRllDRk8yNTQrMGd3eFhIWG4vMWZxQ2U3?=
 =?utf-8?B?WUJ1VUw0Q2lvSTFPZTVVbHBmZWpLZDFhMkpKRS92dW9yV3lpbGpLOExVR1Fl?=
 =?utf-8?B?MkZ4ZVIrZG5XVDhPREdpTTFTTzhNYmg5aTRSdmZ2UGJZaUdOOSt3Z1FyWVFj?=
 =?utf-8?B?ZHJhZ2hwZ0RqMnpBRzJpdmlhdFRXbG1HZXZVZFVVOFBEK3pZWS93TENBcE1l?=
 =?utf-8?B?YVZyVk9nOWFRN3FlNVlzREFZME0ybkRqTjRzdHFYNmpIYndFWGRPVFE2QktP?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D95C776F2E1E0479B14C02949E65450@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1962.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d69b2c4-cea1-4388-691f-08da5a20eed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 22:44:31.8410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 35GHfZ0csnfZAXXR9mP7x7+OhbpI6pBhxfLxehsE5lnn15b2JlIk7D7e3EcbRdLbYfGfE+6fAd85giIpSFScGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
X-Proofpoint-GUID: EGXPB7kQJdvo3EdXgbdd2qiJtJlwwUYL
X-Proofpoint-ORIG-GUID: EGXPB7kQJdvo3EdXgbdd2qiJtJlwwUYL
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 clxscore=1011
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290078
X-Spam-Score: 0
X-Spam-OrigSender: omrimor2@illinois.edu
X-Spam-Bar: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGVsbG8sDQoNCkkgYW0gYSBQaEQgc3R1ZGVudCB3b3JraW5nIG9uIGEgbmV0d29ya2luZyBydW50
aW1lLCBzaW1pbGFyIHRvIE1QSSwgdGhhdCB3b3JrcyB3aXRoIElCVmVyYnMgYW5kIG90aGVyIGxv
dy1sZXZlbCBIUEMgbmV0d29ya2luZyBpbnRlcmZhY2VzLiBJbiBteSByZWNlbnQgd29yayBJ4oCZ
dmUgYmVlbiB1c2luZyB0aGUgU0RTQyBFeHBhbnNlIGNsdXN0ZXIsIHdoaWNoIHVzZXMgMnggQU1E
IOKAnFJvbWXigJ0gQ1BVcyBhbmQgSERSIEluZmluaUJhbmQgc3VwcGxpZWQgYnkgTWVsbGFub3gv
TnZpZGlhIE5ldHdvcmtpbmcuDQpBZnRlciBleHBlcmllbmNpbmcgc29tZSB0cm91YmxlIHdpdGgg
YSByZWdpc3RyYXRpb24gY2FjaGUgdGhhdCBjb3VsZCBjYXVzZSB0aGUgQ1BVIGFuZCBIQ0EgcGFn
ZSB0YWJsZXMgdG8gYmVjb21lIG5vbi1jb2hlcmVudCwgSSBkZXZpc2VkIGEgd29ya2Fyb3VuZCB0
aGF0IG1ha2VzIHVzZSBvZiBleHBsaWNpdCBPRFAgcmVnaXN0cmF0aW9ucywgd2hpY2ggZm9yY2Vz
IHRoZSBIQ0EgcGFnZSB0YWJsZXMgdG8gYmUgdXBkYXRlZCB3aGVuIHRoZSBwYWdlIGlzIG5vIGxv
bmdlciB2YWxpZCBvbiB0aGUgQ1BVLg0KDQpJbiB0ZXN0aW5nLCBob3dldmVyLCBJ4oCZdmUgZGlz
Y292ZXJlZCB3aGF0IGFwcGVhcnMgdG8gYmUgdHJvdWJsaW5nIGJlaGF2aW9yIGxlYWRpbmcgdG8g
cGVyZm9ybWFuY2UgZGlmZmVyZW5jZXMgYW5kL29yIGRlZ3JhZGF0aW9uIHVuZGVyIGNlcnRhaW4g
Y2lyY3Vtc3RhbmNlcy4gV2hlbiBhIGZyZXNoIHNldCBvZiBwYWdlcyBhcmUgbW1hcOKAmWQgYW5k
IHJlZ2lzdGVyZWQgd2l0aCBleHBsaWNpdCBPRFAsIHRoZXkgYXJlIG5vdCBuZWNlc3NhcmlseSBw
aW5uZWQgaW50byBwaHlzaWNhbCBtZW1vcnkuIElmIHRoZW4gYW4gUkRNQSBXcml0ZSBpcyBwZXJm
b3JtZWQgdG8gdGhlc2UgcGFnZXMgYW5kIGEgcGFnZSBmYXVsdCB0cmlnZ2VyZWQgYnkgdGhlIEhD
QSwgdGhlIHBhZ2VzIG11c3QgYmUgcGlubmVkIGFuZCB0aGUgbmV3IHZpcnQtdG8tcGh5cyBtYXBw
aW5nIGFkZGVkIHRvIHRoZSBIQ0EgcGFnZSB0YWJsZXMuIFRoaXMgYWxsb2NhdGlvbiBvZiBwaHlz
aWNhbCBwYWdlcyBhcHBlYXJzIHRvIGlnbm9yZSB0aGUgY3VycmVudCBtZW1wb2xpY3kgc2V0dGlu
Z3MgYW5kIGFsbG9jYXRlcyBhbGwgdGhlIHBhZ2VzIG9uIHRoZSBOVU1BIHpvbmUgY2xvc2UgdG8g
dGhlIEhDQSAob3IsIGFsdGVybmF0aXZlbHksIHRoZSBOVU1BIHpvbmUgY2xvc2UgdG8gdGhlIHRo
cmVhZCB0aGF0IG1hZGUgdGhlIHJlZ2lzdHJhdGlvbuKAlHRob3NlIGFyZSB0aGUgc2FtZSB1bmRl
ciBteSBjdXJyZW50IGNvbmZpZ3VyYXRpb24pLiBCeSBtb2RpZnlpbmcgZWFjaCBwYWdlIGluIHRo
ZSBhbGxvY2F0aW9uIHByaW9yIHRvIHJlZ2lzdGVyaW5nIHRoZSBNUiwgSSBjYW4gZW5zdXJlIHRo
YXQgdGhlIHBhZ2VzIGFyZSBwcmVzZW50IGluIHBoeXNpY2FsIG1lbW9yeSBhbmQgZm9yY2UgYWRo
ZXJlbmNlIHRvIHRoZSBtZW1wb2xpY3k7IGhvd2V2ZXIsIHRoaXMgc2hvdWxkIG5vdCBiZSBuZWNl
c3NhcnksIGFzIHRoaXMgY2F1c2VzIHVubmVlZGVkIG1lbW9yeSBhY2Nlc3NlcyBhbmQgcG9sbHV0
ZXMgdGhlIGNhY2hlLCB3aGljaCB3aWxsIGJlIGV2aWN0ZWQgYW55d2F5IGR1ZSB0byB0aGUgaW5j
b21pbmcgUkRNQSBXcml0ZS4NCg0KU3lzdGVtIGRldGFpbHM6IFNEU0MgRXhwYW5zZQ0KRGlzdHJv
OiBSb2NreSBMaW51eCA4LjUNCktlcm5lbDogNC4xOCAoNC4xOC4wLTM0OC4yMy4xLmVsOF81Lng4
Nl82NCkNCklCIEhhcmR3YXJlOiBNZWxsYW5veCBUZWNobm9sb2dpZXMgTVQyODkwOCBGYW1pbHkg
W0Nvbm5lY3RYLTZdDQpJQiBGaXJtd2FyZTogMjAuMzEuMjAwNg0KDQpOb3RhYmx5LCB0aGUga2Vy
bmVsIGhlcmUgaXNu4oCZdCBwYXJ0aWN1bGFybHkgcmVjZW50IGFuZCBkb2VzbuKAmXQgc3VwcG9y
dCBtYW55IG9mIHRoZSBuZXdlc3QgZmVhdHVyZXMgaW4gSUJWZXJicyBlLmcuIGlidl9hZHZpc2Vf
bXIuIFRoaXMgYXBwYXJlbnQgcHJvYmxlbSBtYXkgaGF2ZSBiZWVuIGZpeGVkIGVpdGhlciBpbnRl
bnRpb25hbGx54oCUdGhvdWdoIEkgZGlkbuKAmXQgc2VlIGFueSBjb21taXRzIHNwZWNpZmljYWxs
eSByZWZlcnJpbmcgdG8gdGhlIGlzc3Vl4oCUb3IgdGhyb3VnaCBoYXBwZW5zdGFuY2UsIGR1ZSB0
byBvdGhlciBjaGFuZ2VzIGluIE9EUCBiZWhhdmlvci4gSeKAmWQgbXVjaCBhcHByZWNpYXRlIHNv
bWUgaGVscCBpbiBhKSBjb25maXJtaW5nIHRoYXQgbXkgb2JzZXJ2YXRpb25zIGFuZCBoeXBvdGhl
c2lzIG9mIHdoYXQgaXMgb2NjdXJyaW5nIGFyZSBjb3JyZWN0LCBhcyBvZiBMaW51eCA0LjE4IGFu
ZCBiKSBkZXRlcm1pbmUgd2hldGhlciB0aGlzIGlzIGZpeGVkIGluIG1vcmUgcmVjZW50IGtlcm5l
bHMuDQoNCk1hbnkgdGhhbmtzLA0KT21yaSBNb3I=
