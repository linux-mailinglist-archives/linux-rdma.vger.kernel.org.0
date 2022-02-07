Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCDC4AC2E2
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Feb 2022 16:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbiBGPVN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Feb 2022 10:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442586AbiBGOzn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Feb 2022 09:55:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9306EC0401C1
        for <linux-rdma@vger.kernel.org>; Mon,  7 Feb 2022 06:55:42 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217DdoNp004444;
        Mon, 7 Feb 2022 14:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=g5h0lceagkswjJHdNLQJOwq9KZRH9X/7ykTzVQGZYZU=;
 b=TrsnrwFyFZuUKRRmAhjUFMpRVG/MNvazmbDNc3J1S4alS+Pc0WjPCj0cwMzkEqXRiOoK
 zjvs+5UIRjEDt1HZc8WlefKaUN6uPuDjOFFA4zQVpImfnGKuWZaJpoKqLq3leOt9BV6w
 Wy//lEGDvoNeNRq3MzGENneMFZSpHZeiukp06Ib0VYE/2yLIqmZl0wXAgIs0Syr+TjJY
 lblhVvTGUppvODcAE2lcElf3x6qVhjbFW1Z9TqlkxwNJkbIeOVjpcWvuyZqU54d+EcfD
 u1FvNyRgdC0eV8j9waHtFbMHmHUogqvwvtbhfr1nVQESHRY+dHeZV6I6zp6Lpc9k1AnY qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1g13ph28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 14:55:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 217EtUp2118269;
        Mon, 7 Feb 2022 14:55:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by aserp3020.oracle.com with ESMTP id 3e1h24dhef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 14:55:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8iggAG1xEI+lqS57scJ50aLB9DlB+nXQGn2nhV36Fv/DKJ5FdZLpHXp/EmpMai67vWPWrKy/ymxxsPufvnso9ywJ9LAbfOjBy8erGxaLEUVcpFsioQoJJpjQBrC35sOgzLsH+220nuxJ4hex0LIciIrpDClYle8BBYq9IIAhbsqakEGbwpqYAneJMXwMv0f0wDbCYWWZk2Wj4utWnhxcBhzCmLIz4No3dhX5hWssGJY7DTczun3ocgBWQl4gcGeca++lEMFPyLUuSpXDb6JkIs08hOf87p3GRck63oOGJg2lcOak6aqzp4AZSm1GEarxnMvApNkcstqzwAclZz6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5h0lceagkswjJHdNLQJOwq9KZRH9X/7ykTzVQGZYZU=;
 b=cHLc3kTWImqPBik4tj8ZFH3ycTj0dC3yMhpqRSma3egRkQOKSKV7flBmAoyLiQ8/dpmm/JPmgBYkYlRLWG8R2/X5mGWt6HdUjONX/fHPsckNsj3PZIN9lxGqu8QtfHK0lKXqEFl7WjDc4mKgkBKQuFwXPxR1+oJ6MAgJ8xvH1Hd1jpaiLQ5zla+O4zyJrKR9IQTb2+y6YEhKq4NUqJgs/oFPmINV91N0yw7j7dsfXmYvUfeaFsfv1G2eVnRjyqN0pXtqj6erWoJ4CzoQOrWZsvV2UzjP8b490NNoYRCdQDcP0RDgpEASvOyuCFUsYIldu9rpuZSNwUl8dAD/BNY7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5h0lceagkswjJHdNLQJOwq9KZRH9X/7ykTzVQGZYZU=;
 b=WHfreKP2XQ685HdlF2pDnIEpddYTGAbd79GprXr/jL+Dty3kLqG0Zn8emSVW80ED9WGWKhy8GW4wkxTTFPQ3j/jwM4NSuaxhb7YESkpJo9/dM5LGmjcCOk9DDE+tCz9yqClAlqx91jg7Pl/tUE1DM35IF+7EVUONky3U90q3ECo=
Received: from SN4PR10MB5590.namprd10.prod.outlook.com (2603:10b6:806:205::5)
 by BL0PR10MB2961.namprd10.prod.outlook.com (2603:10b6:208:33::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 14:55:35 +0000
Received: from SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0]) by SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 14:55:35 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Seeking clarification on the XRC Annex wrt. a TGT QP having a SQ
Thread-Topic: Seeking clarification on the XRC Annex wrt. a TGT QP having a SQ
Thread-Index: AQHYHDLCuOpKqQZz20+R1fZm01/CZQ==
Date:   Mon, 7 Feb 2022 14:55:35 +0000
Message-ID: <6FD25F7D-6F5A-4990-A179-5ED213001BB7@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 831c5f0d-3707-4328-f7d5-08d9ea49e578
x-ms-traffictypediagnostic: BL0PR10MB2961:EE_
x-microsoft-antispam-prvs: <BL0PR10MB29613897CBA6401AEB0A21BAFD2C9@BL0PR10MB2961.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IYYvxmgrprn3+dKb/JmJbXjEeVsyZ6lLCSa/xa4Yq82h0z8p/epD/GxMcXm1EUZAJ1vrSxeT4Oxg4FQq3kzS6lwh41t4hqIou9koiJoJDIZGwY//AiYHDBMJN+F4QM7XGoSn33MhKQcIpPLx7QKhzAE/O5B+KI29SigR49pllF7lZlBOXNyI56KKZJrixVC4OwSB8nDMZaCPXIRkWKFWkS7kwK/mBUNNcThAmnGZxEP3W6nqO4OZmkg3bUd0l+z6+5uf6OaGgd72M4XZKHZEjSRIYu+mXrqWkPO7w2R8fLup5AsNn/D91BCsLlbwMtFA+DLzBQRj8PnP33lAA352TjZlLpaqV9oQ1rX3hZ4JTlEFA9SIy2YcOGyvjzetqBUxKuDZiGLWnApCj+AkBlnAM5WVcdm888V8eviwyrbGxLTK2MOIw77cqXgJKl/YPK+Yfd4Kjv509kRKNwdXDQecC/jvFBqUSvRCuukdKyTNdeLeRta6gnd3ULlQUwPzOkcT4R/XrMqdamzqhy1DWnn41sMvo1izz80gZNuUqrfM1pa0weiUo9OX2Z39FBDh0/f3RhZKy/s6jKiemaf9oyr5isEXwORA7eJhPYl7nDSEverXP3ahPD+I96MzJmqes3SnsK1HXZD8IrZ+25Kg4/wl1XHOF6Av+m765oX9Sw3Bn88syohOJwVHC93Zbfdj2RIvCsnmds8/igmiI7VXyFkPr4oYGqks1biPHMw8bkmX5Ko0OmaTH0dtPxOzyQVnkgr0ajVyXlwnEPPgFj42ZQG00w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5590.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(186003)(2906002)(76116006)(26005)(4326008)(54906003)(8676002)(6916009)(8936002)(64756008)(66446008)(66946007)(316002)(66556008)(66476007)(36756003)(5660300002)(83380400001)(91956017)(2616005)(33656002)(6506007)(38100700002)(6512007)(122000001)(86362001)(38070700005)(508600001)(6486002)(71200400001)(193643001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEp4c0pnZWorajdzbURadWpmbHkzazB6YktweVl0Nm9ibFBUWlVsaSt5aEJk?=
 =?utf-8?B?R2w1UFViUnYxLzRHcWJsUzNCRlZJZDFubUIvRHIzYWpNOWZCQkZoUGxUWEdR?=
 =?utf-8?B?bGtHaHFCa21LSUlqdlJCSFhKTTRnZmdWVHp4eUlTQ2lURTNIRnRYRVlTQXhD?=
 =?utf-8?B?R1ZjZjllanNtaVZJdGEvVnBveHYwQUdQbWZ4allVUkJzT1hoR2J2THh0WC93?=
 =?utf-8?B?SkVaS1dMNnBXWkx1WEx5UFI4QXFoS1o3UkE4QWI5U29HOUhPeTdxdFBSOE5N?=
 =?utf-8?B?Z0xOOHVKckxvWXhKbmVvQ0RvK0Q1NlZrQ0E1aC9MbUcxd21OMkRrWTVMcndP?=
 =?utf-8?B?ckcrRmpCbVNuRi9ZRHBySDZ0QlFFalUxMXlVZENFTENWbEtpMGhVdmFnZmd5?=
 =?utf-8?B?NGdjcG5qS28wUjZjdmlwazUvZkZZRHhORDlSUDNXOFNNQ0VxNFdkUE1pZ3FX?=
 =?utf-8?B?Z0JqdnluTTYvVW85T1FFV0RqcjlXcE1PTUYzQnltSEVmOEx2NlJmWmxyTWhV?=
 =?utf-8?B?TkV0dEN2Z29iY3h1VVlxQzBDU0FUOHZtajFiK1Eycnh1Nk95UXFyMEJiS2Yr?=
 =?utf-8?B?eWNlVjVrc0xOVXFVdUJjaC9SLzEzR2NVN3NYR011SURFNXYwVTFNYkxtcXVY?=
 =?utf-8?B?ZUlEdm9jUXBtWXY0VEtlWlJrenFlRjJCV3lRUVRNbG5seHZlbW5HeXN5Yk9x?=
 =?utf-8?B?UGE4eHArejdnTGhJbUFzdEtMOWRzQ2ZTOCsvb3poOEJTZ0Fod0JhNXA1WDcz?=
 =?utf-8?B?WEkrTzg1YzQvUi9RTm1ZM2hWNVZ3Qm1hYUZlRlNwb0h4NEJTOEZ1RGY2Q3Ir?=
 =?utf-8?B?NTZMVmkxeGJIVjhJWEdpcFVXS3cvSUhjTFpmYmVrSmJjUTUrN2VoZkRqRTF2?=
 =?utf-8?B?VFJPREdwcXJNUWdtUjA3ZXYyM0d5ZG9FcHpBUGZXQy8rZmN0alpJUkhYa2ow?=
 =?utf-8?B?UmUwNVlpSTFOaWNtS0w4UmpkL3lrS1pmR2NJRUR2R0VjMVIzYjkrWlV3cHFD?=
 =?utf-8?B?eHVtREhleFBQZ2V0V3c0d0lqTUtvVForc2JKUG9hdHJtVURKa3FibWtaNStO?=
 =?utf-8?B?aUZ3UDFGZEhSa2g2NkJZdmRtSHhRbmp0S01UK0g4V2ttczAvbUs0WWZUTkhJ?=
 =?utf-8?B?VmFZUHMwUTN0VWZEb25BdlZQOSswdlpITzVKanVTUFZlb3dTN1BMWEhXUWtI?=
 =?utf-8?B?dXNWVEdLM0JPQi9sSk42elZtazFCb2w1WmxwY2d2R1JFNUJ2ZjMyWmlCYkZn?=
 =?utf-8?B?ZVhjbHpWckp0WlVROU1GNmxHQmVaWkozYVZySHQ4aTA4UGNRSWNpcDVSN1FX?=
 =?utf-8?B?dzlqNk44TEhaN0pWUTA0L3NNbzZHUVR2eWUwanhWd1MxQlF6SGdUdW9zdEpE?=
 =?utf-8?B?NlFjc2FYQ3hsTWFTRURnTkEyLzl6YmdVTFZDYWc1K21pME9objUrZVQycmhq?=
 =?utf-8?B?SzN4SEJvTitoZFhZNlN0dmJ4bGpLZW54bGhtMlFrT1BwSExJOVdFZzhNV0RV?=
 =?utf-8?B?UTAvRkdmMzEwT2FTZWQ1TmhRSWtNTVIrYU9wd3pOcTg3WVVRNUsyd0YwcCs1?=
 =?utf-8?B?YTFWNzNpdWw2TlVVVFdCMzRHek5xZ0FhVGo0dzNqQ0ZjN1psdGZsUlpVbDg0?=
 =?utf-8?B?em5ZdGEway9qUmxXbU1QVzlFMHc2c2ZSTVVCKzk2MHEyeDZNUjFCTEtSU3dl?=
 =?utf-8?B?R0RhTnM3MFJ4c3V1d0psZ1VEVHJHVGtjUWYrbVRLZUlueVFLWkF3cXhnNjRX?=
 =?utf-8?B?azVNdnlJZURQQ2Uzbm1yZEliUlN2WjNrSXQ2YkhnQ3BpUW13VlRiSjRyclNL?=
 =?utf-8?B?RnUrZlVXRWQ4Y2t5cFh3OGl2bVZoalhPL3RyQzNXQzNnWElJaUtSS1VmYnRO?=
 =?utf-8?B?MlQzb3VVeGhTK1VSNHZaSVFpZm1EeUpBQStDWnlmd1A4TU41RGRNT0p1aENU?=
 =?utf-8?B?Sk1VY0JLQWhnWVA3THZvOUVqS1NaSGxUNE9EUHlZVml1dXBjMHZVcXlZUGJB?=
 =?utf-8?B?OFZJSEI4cGVENDNBaDEwSEJnYndDODltRmpKMGJ5UEhMRmtvRXNPck5YMDRZ?=
 =?utf-8?B?ZmRoU3hLLzBHeTIvSGljUjFzZGpBK3diYzBuenNhZUZvcDVzNU05YlJvS3or?=
 =?utf-8?B?OFkyTkU4Ym9tWGY2MXBPSy9weGNWWGVzYUhGNjlGY3hlcUFubnFEckhDUjFH?=
 =?utf-8?Q?oSQc5vOw1HYXYpShd+AjGWY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1230B947E660A44D877F8C2AE324E24A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5590.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831c5f0d-3707-4328-f7d5-08d9ea49e578
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 14:55:35.2277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hGwKp1OQLAUO/MMNywXHefpVgSRLE/I+DXxKbaDgjjVUyR3AQ7/Lh01G20HXZ1jg6qNaHBa7P7KG6l2KivhoWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2961
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10250 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=992 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070096
X-Proofpoint-GUID: 9HcoezIG0vMybhIejrNM38yxUHsDOcfS
X-Proofpoint-ORIG-GUID: 9HcoezIG0vMybhIejrNM38yxUHsDOcfS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGV5LA0KDQoNCkkgaGF2ZSBhIHF1ZXN0aW9uIHRvIFhSQyBUR1QgUVBzIGFuZCB3aGV0aGVyIHRo
ZXkgZG8gaGF2ZSBhIHNldCBvZiByZXF1ZXN0b3IgcmVzb3VyY2VzIG9yIG5vdC4NCg0KDQpUaGUg
WFJDIEFubmV4IChNYXJjaCAyLCAyMDA5IFJldmlzaW9uIDEuMCkgKCoxKSBib2xkbHkgc3RhdGVz
Og0KDQoJWFJDIFRHVCBRUHMgYXJlIHNpbWlsYXIgdG8gUkQgRUVDcyBidXQgZG8gbm90IGhhdmUg
YSByZXF1ZXN0ZXIgc2lkZS4NCg0KDQpOZXZlcnRoZWxlc3MsIGluIFRhYmxlIDksIHBhZ2UgMzYs
IGl0IGlzIHN0YXRlZCB0aGF0ICJMb2NhbCBBQ0sgVGltZW91dCIgYW5kICJTUSBQU04iIGFyZSBy
ZXF1aXJlZCBhdHRyaWJ1dGVzIGR1cmluZyBhbiBSVFIgLT4gUlRTIHRyYW5zaXRpb24gZm9yIGFu
IFhSQyBUYXJnZXQgUVAuIFRoaXMgc2VlbXMgdG8gYmUgYW4gaW5jb3JyZWN0IHJlcXVpcmVtZW50
LCBzdWJqZWN0IHRvIHRoZSBYUkMgVGFyZ2V0IFFQIG5vdCBoYXZpbmcgYSBzZW5kIHF1ZXVlPw0K
DQpGdXJ0aGVyLCBsb29raW5nIGF0IGEgdmVuZG9yJ3MgY3JlYXRpb24gb2YgYW4gWFJDIFRHVCBR
UCwgd2Ugc2VlOg0KDQoJTUxYNV9TRVQocXBjLCBxcGMsIG5vX3NxLCAxKTsNCg0KaW4gdGhlIGZ1
bmN0aW9uIGNyZWF0ZV94cmNfdGd0KCkuDQoNCklmIHRoZSBpbnRlcnByZXRhdGlvbiB0aGF0IGFu
IFhSQyBUR1QgZG9lcyBfbm90XyBoYXZlIGEgc2VuZCBxdWV1ZSBpcyBjb3JyZWN0LCB3ZSBjYW5u
b3Qgc2ltcGx5IHJlbW92ZSAiTG9jYWwgQUNLIFRpbWVvdXQiIGFuZCAiU1EgUFNOIiBhcyBtYW5k
YXRvcnkgYXR0cmlidXRlcyBkdXJpbmcgdGhlIHN0YXRlIHRyYW5zaXRpb24sIGJlY2F1c2UgdGhh
dCB3aWxsIGJyZWFrIGFsbCBjdXJyZW50IHNvZnR3YXJlLiBJcyBpdCBhbiBpZGVhIHRvIG1vdmUg
dGhvc2UgdG8gb3B0aW9uYWwgYXR0cmlidXRlcyBpbiB0aGUgcXBfc3RhdGVfdGFibGVbXT8gVGhl
biByZW1vdmUgdGhlIElCX1FQVF9YUkNfVEdUIGxhYmVsIGluIGNtX2luaXRfcXBfcnRzX2F0dHIo
KT8NCg0KDQpUaHhzLCBIw6Vrb24NCg0KKjE6IElCVEEgU3BlYyBSZWxlYXNlIDEuNiBpcyBlcXVh
bCB0byB0aGUgWFJDIEFubmV4IGluIHRoaXMgcmVzcGVjdA0KDQoNCg==
