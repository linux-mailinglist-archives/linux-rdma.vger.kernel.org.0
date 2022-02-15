Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D554B699D
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 11:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbiBOKoU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 05:44:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbiBOKoT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 05:44:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0F4AFF4D;
        Tue, 15 Feb 2022 02:44:08 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FAH3bG007111;
        Tue, 15 Feb 2022 10:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PRM6ke0AHYsA4qouRLqtnyM2ujzwAswISfsCV+aqtjg=;
 b=L3CPp1v08GUmNUu3+5FTpbRuXAJt7H7bJY2BHATJENaBSj5uWr/tZTT4JGKrHBWlkgKY
 K55MLGNb4XIgFx3TKUXh7N+cYdpg9N2z0NIswMW2AFJCCB/1tCx2ENRn3qcFVnWzlPeC
 Y1EGFjRxtQl84f45iqKJwlcUBdj4KLxrspOI1xIx6U4X41yGYQ7DEJAobnl9cLUoVtIn
 97Akx33Ls4SyhiqGqkvgMKz+/fa5SHDDYA4+ly+1sio7Yb52VX7tn0Hk3z0pevppMLun
 c/6pChBOOtcu9mEF6xohhaVyewZPvDlBexZNRtHa8ni3x5U6s9qak/fmjP1LWumrGjPi zA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e884r8hqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 10:43:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FAeTWG050657;
        Tue, 15 Feb 2022 10:43:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3030.oracle.com with ESMTP id 3e62xechyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 10:43:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFukAj/p6t0Er8X7KFKpJyWjQvIu1Umwu9whsTNF6B7R1hjgArdD1MHtWsTvmTquXGINqM5k/iiPnD6s1hCl64t6EdmCAOg4z8mThqC+c8ObgT7osbUsDbf0QaGlZHc0Qh64kg5WOqmrOnXYKeIq+6GjA4NtWJBDpk65u5kYo8k6nIW0YsJAyfyx939UDpok9FlLIaUPM+yzE+TOEQMipYybEH6muWd6/dcgexEUDZnGG1MTTf2SJAEdiX38yjsvzbJGE2SHD38O+kRCFl8t0xFh4gL/WXQee1BDbPmbJaD8IYuJR4FU6prV51+sYJ5wsEIZ/WCwZXYpodFuTKgNCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRM6ke0AHYsA4qouRLqtnyM2ujzwAswISfsCV+aqtjg=;
 b=EAkRPN3EKoeJwBVkZjymQWVuRAHjJwEK2taqaZ+P7KZiktzMoSRp/I6DLDehSbQCMs2jWq7pDhk4lv0JUEapTY2vaERAcpIwGpAhxP++nP46Ut+u7Gy50spcOXpPcmPsrbPdKYnPZY4q8gqWBC3AemUkHEFlDUWPhkK6d62kjxqH07kRSSCNtcOcE3bX0Q2th3y2/QJ+qbPAThV/f8+IfuOD0a80C9WlYrnHqEFintYWTERmwUy5WOxe24s80Db3fnh7w2lo1rQZ1tA3UGNdQp1clDUG5f5D/FGuPYiXTNhRtDOD7W9O8BwCoKP90KeMWw1m9A9QzxOzpvCVdW2Uiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRM6ke0AHYsA4qouRLqtnyM2ujzwAswISfsCV+aqtjg=;
 b=ZnDdxoeqk8RETebT6lyTIa1sL3PMc7mReB/WVYq06cvhodyhYVjRkeEwYdCaV7aTY+ul9G9q2jvxn/oVy+2TNlJLtp3GtTgmpOrykZSfJNTHbTde0NvL+SA4QRk6rBow3118zxJCMhb70YlUQCWqcmTVw3FR+VR6mku7oJCUahE=
Received: from SJ0PR10MB5600.namprd10.prod.outlook.com (2603:10b6:a03:3dc::12)
 by DS7PR10MB4912.namprd10.prod.outlook.com (2603:10b6:5:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 10:43:48 +0000
Received: from SJ0PR10MB5600.namprd10.prod.outlook.com
 ([fe80::5b6:33a0:d015:36a5]) by SJ0PR10MB5600.namprd10.prod.outlook.com
 ([fe80::5b6:33a0:d015:36a5%3]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 10:43:48 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        syzbot <syzbot+831661966588c802aae9@syzkaller.appspotmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [syzbot] possible deadlock in worker_thread
Thread-Topic: [syzbot] possible deadlock in worker_thread
Thread-Index: AQHYHrRGZ1eWC5CyIUqr8tRZWA61Q6yOtbMAgACwk4CAALoWgIAACiCAgAH00YCAACHoAIAAK7SAgACljYCAAEJtAIABGqQAgAAE4QA=
Date:   Tue, 15 Feb 2022 10:43:47 +0000
Message-ID: <76616D2F-14F2-4D83-9DB4-576FB2ACB72C@oracle.com>
References: <0000000000005975a605d7aef05e@google.com>
 <8ea57ddf-a09c-43f2-4285-4dfb908ad967@acm.org>
 <ccd04d8a-154b-543e-e1c3-84bc655508d1@I-love.SAKURA.ne.jp>
 <71d6f14e-46af-cc5a-bc70-af1cdc6de8d5@acm.org>
 <309c86b7-2a4c-1332-585f-7bcd59cfd762@I-love.SAKURA.ne.jp>
 <aa2bf24e-981a-a811-c5d8-a75f0b8f693a@acm.org>
 <2959649d-cfbc-bdf2-02ac-053b8e7af030@I-love.SAKURA.ne.jp>
 <YgnQGZWT/n3VAITX@slm.duckdns.org>
 <8ebd003c-f748-69b4-3a4f-fb80a3f39d36@I-love.SAKURA.ne.jp>
 <YgqSsuSN5C7StvKx@slm.duckdns.org>
 <a07e464c-69c6-6165-e88c-5a2eded79138@I-love.SAKURA.ne.jp>
In-Reply-To: <a07e464c-69c6-6165-e88c-5a2eded79138@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f3446ef-4b93-4217-24d1-08d9f0700c23
x-ms-traffictypediagnostic: DS7PR10MB4912:EE_
x-microsoft-antispam-prvs: <DS7PR10MB4912EA3FE67785B539401235FD349@DS7PR10MB4912.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /u/Cbroj4mcKcCwoani801dhswmjz365DTaNn15bYVLQBprS+ev/O3sFGEOkhZMWdcIkaLWpAJF9yoEwnS0tSHbzngmd2e3oZT8EtPefxivinjVX/AJA8qHmqH4kCwamssoDJlhhApEzhBCkCahSKEvKUaP/Cdt/FMZv/HH1LaZx5V8A4l1c8+t2VUU1kRkxb1ZJtyB7GQzt72L0QRgfXEwB2axCAJTiHdg6is94RFPpsm5qEUUibEAsP7Jh0xHEIVkQHXo75+T23AapJoQ+nTnna2CENvxfhnR9L4/odbHYd2rytN2PBBViIf8XJ9tcOZhOT7ZbszMvh1AwB2IC5i9H+nYlaClGRQ9CFQWSOAsQPB+IhY1FrAJz/wpw7SLqioDTxTmoiElpOUm3gNxQVB7JprIzVSqvZQpetGyBdOfZDFMNWohFGfOSxYIavR0d3z9PNYT+mpFrBx67HyX41NDJB98AemNzhzFezh46xw5DO+Xw9Q9xDd2MWPDmQADf1CipaTaYxc8G3IZiPSRtGLqV9cXnmHuTm1vzwY16CJmS1oCi790bHO6exU3SPyGliuOsEq/GeZK7cDVprykJpxxkCog0eZwjAVuMmpU95mHFZMAM0eGw76c0WVzYegD4/gGm29iXU9+70Z5ULQ871R2Lf4YlHyXH5xNt/Tfiwbce0zl4Qxl4HUyMfWp9Y4coGUgzKsvEtduhygfT0A95FZrCEquOGelYplHtlyLQ6aEyB2bsjosthwNt7SqlSbP9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5600.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(83380400001)(6512007)(66574015)(26005)(8936002)(5660300002)(44832011)(2906002)(36756003)(6506007)(33656002)(508600001)(53546011)(71200400001)(6486002)(38070700005)(91956017)(4326008)(8676002)(66476007)(66946007)(76116006)(64756008)(86362001)(66446008)(316002)(66556008)(38100700002)(54906003)(6916009)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWZNNVB2YktkT0diaGcwbkhSWUpnUnNSTjc0MFZEM1ZyejlpNDlkVTJKdm85?=
 =?utf-8?B?MnNkZ0FFVEVGeE9UU01LVncrbDdybkY5SWU3clZnZHJHVDk3V1hGeW1ydnEz?=
 =?utf-8?B?Q1phVGV2T2luT1VudTNQWE9PZ2Y1NEI2V2Z2SWdHRGNSRkV0UnFrZjlCTFNv?=
 =?utf-8?B?dWJ4UHBZbi95b3REektERzFRTm02cUZSQmFIQ0QrdTU3Zmw2RkF2N25RZkYy?=
 =?utf-8?B?UUxlcURUak0wdDRFYXFhMWNpU25RckM1VkRFZitadUt0T0NRcHhFM0ExSnFJ?=
 =?utf-8?B?WG44QnN5WXNBbkkraGNvNGRVempyeU1RZXVBc1lYdFkyaG1zNXhvMWZPcnVk?=
 =?utf-8?B?Z05VdHFNNG5oNVRNdHlOOG5TUXJkOVhJYndqY0E2TXMweEx5ZDB6S2JFYzhl?=
 =?utf-8?B?QlE5eDVMR3pwNDV5aHFSMlBnY2ZwR21icEdFV2J3aTU5VlozcVlwcEtxdWYy?=
 =?utf-8?B?QldMRDlKRzltMW5pY1R0eWIrMzVhVnRIYldOZ0E0dFMxWGxZNGxSR08vZjhp?=
 =?utf-8?B?dyt4djQyekVBemRoVFZvQWQrV1ZtbXQra0NhR2p0KytMVzZUbmg0a1ExUkho?=
 =?utf-8?B?cFhFRzVBbWZxQjBVSDZZWmtQNTZMU2RTdENLWFhxTWJmeHMxTXlDYjBaR3Jq?=
 =?utf-8?B?QjZ5RURMYzZmWjBYQ3FzNlpwRUxjcjJsdXQyZy9iRlpwNnBJVEZITm9hekFB?=
 =?utf-8?B?bTVLUTlsbVl4NHdnRzdOMHJYYXZFYThyNmZOYzU5d3JaR1RVR0pRUzUwdnBz?=
 =?utf-8?B?YjY0UmF5d2EwcC9zeUY4ZlRnbnk2WXBUTStUaFV0U1hUUGY1emdvVzNVMjRE?=
 =?utf-8?B?TjJSbHlrMjJwSHQveVVXOFEwMEl2VzFWbTJPT3l6RWpKUVBpdVRHOEpDaytI?=
 =?utf-8?B?TXpXWXBVUk5lUko1bHlFMzlKdy9UYXBUUDdGU2lOR3pnSTcwSTl3enh3Tm1p?=
 =?utf-8?B?VXhYS0d3MXRCMGgyUHNRaFRCVDBZZ0VqbHNJSzlMTWNkYW9IQW0vbTNVSWFU?=
 =?utf-8?B?YTE0Z3o5MTVWVlBiQXd3QWZYMlZHd0tvTnV0ZlY0RFpKTmJvVW8rTCtXREd4?=
 =?utf-8?B?SXFOdWpZanp6OWphQmlIblI5VWF1Wm9jM3JOUjQ2ZzVqL2d3b1Y0ZXlSR1h6?=
 =?utf-8?B?OHVXbnFJdUZ2T3VOQUs1aEt2OTl3TjZZZEwxY29mNlR5Rm9kMVpKM1JsM3F6?=
 =?utf-8?B?U3pRSVpzNWcyaXZqd0lET3BzSHJYTzFLZWEwRUJ5MExlYit3Z0xxdyszc0VN?=
 =?utf-8?B?Z3k2UXRDTDVLUjdkNjNBOTZtN3B5TXhXQmNWdkVUcmpHNVZ6cGJnNGgyQ2hN?=
 =?utf-8?B?NisxeTR6ZytwN1IzZGF1b3ZlaXRKcy8xTXFsWTdtZGg0S2QwVVo2OXJvRzlX?=
 =?utf-8?B?TnJJcWlYN3dHZEtvQ3ZPM3lHbklRNWM3KzlCdGdDZm5sbURsZVRPeE8wZWc4?=
 =?utf-8?B?T3JZSGNlcTdpQk9wa21ZRVR4Q2lFakllamZKSStJMWNJb0grMlkvN2pqREl3?=
 =?utf-8?B?b09FNHF5SVNGQzh4YUNBSmVTSW9hSmZoNmpCTi9zZGxQOEIvL3ZXWkFlSE1h?=
 =?utf-8?B?TVhsZ2d2L1Ayd3U2T2EvOHVHVHdHQmpUMEN4dlc1SkZCQnJZWm1uSit3TlhU?=
 =?utf-8?B?blBBc0RKQnhDS01lM1hZMXVhV2hBdFN5N3Z6Vnc0QmhlN2hRNDJGZC9sNlNl?=
 =?utf-8?B?K0RFWXJvVy9sL2xSMEhiZW9qWDNyZ3p3V2NKMFdiMmhyS2pqcWVFUW9XVXZM?=
 =?utf-8?B?Sno5bE1PeDkyMUh3bnZjRFphU3NEU2s2TjEyWnJVTXhaeXhWL3hmalpPS2NL?=
 =?utf-8?B?OTIvRVUxYi9CaTRvcGlKL0NwUW9qTGhHcWdwanVObmVFeGo1L3FVbHJqL3kz?=
 =?utf-8?B?REFIS3lPL3FqS2lxZ3FOOW1CQ0FEWDlLYkpiT2NwakZ5NVJNdmJJVytTVTk1?=
 =?utf-8?B?T3NaZCtzMnhGUDVSUVBEWmRia0RYZlFBYmpFN1hYUU1ORFJIMUh2a2gveEZL?=
 =?utf-8?B?RmgxTzNveDA0ck1SVEg5YjBVTXJRZk1FTFVFYVBUeDhyOVdtMU1DZmtyZ2J4?=
 =?utf-8?B?WE5PbzBpWFk5VHFrdW92TWJ0S2pQVWJJaUd0cXdHZmIzeDVtcldGVS9rZmtX?=
 =?utf-8?B?M0lhc2Z3RFhTMjFMVEdNOGtpRXdES01xZnBPMDlWWlgzcEtsUlU1S1VOTEZG?=
 =?utf-8?Q?e4Y2CuSLGMklCqoSZXUPbMg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44C5391E197D63458F136928CC513717@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5600.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3446ef-4b93-4217-24d1-08d9f0700c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 10:43:47.9019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rlQ0s7maCPkWZRMQW220WJFS+OQlmImQ2rrPOoRxPTLz7VOVtiL4eruVX7ktDo1e9EkO4qoAqXf9domu2V7oSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4912
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150060
X-Proofpoint-GUID: 6fkF56LDkj83P6bS8Aidper423GZfi6k
X-Proofpoint-ORIG-GUID: 6fkF56LDkj83P6bS8Aidper423GZfi6k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTUgRmViIDIwMjIsIGF0IDExOjI2LCBUZXRzdW8gSGFuZGEgPHBlbmd1aW4ta2Vy
bmVsQGktbG92ZS5zYWt1cmEubmUuanA+IHdyb3RlOg0KPiANCj4gT24gMjAyMi8wMi8xNSAyOjM0
LCBUZWp1biBIZW8gd3JvdGU6DQo+PiANCj4+IEluc3RlYWQgb2YgZG9pbmcgdGhlIGFib3ZlLCBw
bGVhc2UgYWRkIGEgd3EgZmxhZyB0byBtYXJrIHN5c3RlbSB3cXMgYW5kDQo+PiB0cmlnZ2VyIHRo
ZSB3YXJuaW5nIHRoYXQgd2F5IGFuZCBJJ2QgbGVhdmUgaXQgcmVnYXJkbGVzcyBvZiBQUk9WRV9M
T0NLSU5HLg0KPj4gDQo+IA0KPiBEbyB5b3UgbWVhbiBzb21ldGhpbmcgbGlrZSBiZWxvdz8NCj4g
SSB0aGluayB0aGUgYWJvdmUgaXMgZWFzaWVyIHRvIHVuZGVyc3RhbmQgKGZvciBkZXZlbG9wZXJz
KSBiZWNhdXNlDQo+IA0KPiAgVGhlIGFib3ZlIHByaW50cyB2YXJpYWJsZSdzIG5hbWUgKG9uZSBv
ZiAnc3lzdGVtX3dxJywgJ3N5c3RlbV9oaWdocHJpX3dxJywNCj4gICdzeXN0ZW1fbG9uZ193cScs
ICdzeXN0ZW1fdW5ib3VuZF93cScsICdzeXN0ZW1fZnJlZXphYmxlX3dxJywgJ3N5c3RlbV9wb3dl
cl9lZmZpY2llbnRfd3EnDQo+ICBvciAnc3lzdGVtX2ZyZWV6YWJsZV9wb3dlcl9lZmZpY2llbnRf
d3EnKSB3aXRoIGJhY2t0cmFjZSAod2hpY2ggd2lsbCBiZSB0cmFuc2xhdGVkIGludG8NCj4gIGZp
bGVuYW1lOmxpbmUgZm9ybWF0KSB3aGlsZSB0aGUgYmVsb3cgcHJpbnRzIHF1ZXVlJ3MgbmFtZSAo
b25lIG9mICdldmVudHMnLCAnZXZlbnRzX2hpZ2hwcmknLA0KPiAgJ2V2ZW50c19sb25nJywgJ2V2
ZW50c191bmJvdW5kJywgJ2V2ZW50c19mcmVlemFibGUnLCAnZXZlbnRzX3Bvd2VyX2VmZmljaWVu
dCcgb3INCj4gICdldmVudHNfZnJlZXphYmxlX3Bvd2VyX2VmZmljaWVudCcpLiBJZiBDT05GSUdf
S0FMTFNZTVNfQUxMPXksIHdlIGNhbiBwcmludA0KPiAgdmFyaWFibGUncyBuYW1lIHVzaW5nICIl
cHMiLCBidXQgQ09ORklHX0tBTExTWU1TX0FMTCBpcyBub3QgYWx3YXlzIGVuYWJsZWQuDQo+IA0K
PiAgVGhlIGZsYWcgbXVzdCBub3QgYmUgdXNlZCBieSB1c2VyLWRlZmluZWQgV1FzLCBmb3IgZGVz
dHJveV93b3JrcXVldWUoKSBpbnZvbHZlcw0KPiAgZmx1c2hfd29ya3F1ZXVlKCkuIElmIHRoaXMg
ZmxhZyBpcyBieSBlcnJvciB1c2VkIG9uIHVzZXItZGVmaW5lZCBXUXMsIHBvaW50bGVzcw0KPiAg
d2FybmluZyB3aWxsIGJlIHByaW50ZWQuIEkgZGlkbid0IHBhc3MgdGhpcyBmbGFnIHdoZW4gY3Jl
YXRpbmcgc3lzdGVtLXdpZGUgV1FzDQo+ICBiZWNhdXNlIHNvbWUgZGV2ZWxvcGVyIG1pZ2h0IGNv
cHkmcGFzdGUgdGhlDQo+ICAgIHN5c3RlbV93cSA9IGFsbG9jX3dvcmtxdWV1ZSgiZXZlbnRzIiwg
MCwgMCk7DQo+ICBsaW5lcyB3aGVuIGNvbnZlcnRpbmcuDQo+IA0KPiAtLS0NCj4gaW5jbHVkZS9s
aW51eC93b3JrcXVldWUuaCB8ICAxICsNCj4ga2VybmVsL3dvcmtxdWV1ZS5jICAgICAgICB8IDI0
ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiAyIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3dvcmtxdWV1ZS5oIGIvaW5j
bHVkZS9saW51eC93b3JrcXVldWUuaA0KPiBpbmRleCA3ZmVlOWI2Y2ZlZGUuLjllMzNkY2Q0MTdk
MyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC93b3JrcXVldWUuaA0KPiArKysgYi9pbmNs
dWRlL2xpbnV4L3dvcmtxdWV1ZS5oDQo+IEBAIC0zMzksNiArMzM5LDcgQEAgZW51bSB7DQo+IAlf
X1dRX09SREVSRUQJCT0gMSA8PCAxNywgLyogaW50ZXJuYWw6IHdvcmtxdWV1ZSBpcyBvcmRlcmVk
ICovDQo+IAlfX1dRX0xFR0FDWQkJPSAxIDw8IDE4LCAvKiBpbnRlcm5hbDogY3JlYXRlKl93b3Jr
cXVldWUoKSAqLw0KPiAJX19XUV9PUkRFUkVEX0VYUExJQ0lUCT0gMSA8PCAxOSwgLyogaW50ZXJu
YWw6IGFsbG9jX29yZGVyZWRfd29ya3F1ZXVlKCkgKi8NCj4gKwlfX1dRX1NZU1RFTV9XSURFICAg
ICAgICA9IDEgPDwgMjAsIC8qIGludGVyYmFsOiBkb24ndCBmbHVzaCB0aGlzIHdvcmtxdWV1ZSAq
Lw0KDQpzL2ludGVyYmFsL2ludGVybmFsLw0KDQo+IA0KPiAJV1FfTUFYX0FDVElWRQkJPSA1MTIs
CSAgLyogSSBsaWtlIDUxMiwgYmV0dGVyIGlkZWFzPyAqLw0KPiAJV1FfTUFYX1VOQk9VTkRfUEVS
X0NQVQk9IDQsCSAgLyogNCAqICNjcHVzIGZvciB1bmJvdW5kIHdxICovDQo+IGRpZmYgLS1naXQg
YS9rZXJuZWwvd29ya3F1ZXVlLmMgYi9rZXJuZWwvd29ya3F1ZXVlLmMNCj4gaW5kZXggMzNmMTEw
NmI0Zjk5Li5kYmI5YzZiYjU0YTcgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC93b3JrcXVldWUuYw0K
PiArKysgYi9rZXJuZWwvd29ya3F1ZXVlLmMNCj4gQEAgLTI4MDUsNiArMjgwNSwyMSBAQCBzdGF0
aWMgYm9vbCBmbHVzaF93b3JrcXVldWVfcHJlcF9wd3FzKHN0cnVjdCB3b3JrcXVldWVfc3RydWN0
ICp3cSwNCj4gCXJldHVybiB3YWl0Ow0KPiB9DQo+IA0KPiArc3RhdGljIHZvaWQgd2Fybl9pZl9m
bHVzaGluZ19nbG9iYWxfd29ya3F1ZXVlKHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICp3cSkNCj4g
K3sNCj4gKwlzdGF0aWMgREVGSU5FX1JBVEVMSU1JVF9TVEFURShmbHVzaF93YXJuX3JzLCA2MDAg
KiBIWiwgMSk7DQo+ICsNCj4gKwlpZiAobGlrZWx5KCEod3EtPmZsYWdzICYgX19XUV9TWVNURU1f
V0lERSkpKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwlyYXRlbGltaXRfc2V0X2ZsYWdzKCZmbHVz
aF93YXJuX3JzLCBSQVRFTElNSVRfTVNHX09OX1JFTEVBU0UpOw0KPiArCWlmICghX19yYXRlbGlt
aXQoJmZsdXNoX3dhcm5fcnMpKQ0KPiArCQlyZXR1cm47DQo+ICsJcHJfd2FybigiU2luY2Ugc3lz
dGVtLXdpZGUgV1EgaXMgc2hhcmVkLCBmbHVzaGluZyBzeXN0ZW0td2lkZSBXUSBjYW4gaW50cm9k
dWNlIHVuZXhwZWN0ZWQgbG9ja2luZyBkZXBlbmRlbmN5LiBQbGVhc2UgcmVwbGFjZSAlcyB1c2Fn
ZSBpbiB5b3VyIGNvZGUgd2l0aCB5b3VyIGxvY2FsIFdRLlxuIiwNCj4gKwkJd3EtPm5hbWUpOw0K
PiArCWR1bXBfc3RhY2soKTsNCj4gK30NCj4gKw0KPiAvKioNCj4gICogZmx1c2hfd29ya3F1ZXVl
IC0gZW5zdXJlIHRoYXQgYW55IHNjaGVkdWxlZCB3b3JrIGhhcyBydW4gdG8gY29tcGxldGlvbi4N
Cj4gICogQHdxOiB3b3JrcXVldWUgdG8gZmx1c2gNCj4gQEAgLTI4MjQsNiArMjgzOSw4IEBAIHZv
aWQgZmx1c2hfd29ya3F1ZXVlKHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICp3cSkNCj4gCWlmIChX
QVJOX09OKCF3cV9vbmxpbmUpKQ0KPiAJCXJldHVybjsNCj4gDQo+ICsJd2Fybl9pZl9mbHVzaGlu
Z19nbG9iYWxfd29ya3F1ZXVlKHdxKTsNCj4gKw0KPiAJbG9ja19tYXBfYWNxdWlyZSgmd3EtPmxv
Y2tkZXBfbWFwKTsNCj4gCWxvY2tfbWFwX3JlbGVhc2UoJndxLT5sb2NrZGVwX21hcCk7DQo+IA0K
PiBAQCAtNjA3MCw2ICs2MDg3LDEzIEBAIHZvaWQgX19pbml0IHdvcmtxdWV1ZV9pbml0X2Vhcmx5
KHZvaWQpDQo+IAkgICAgICAgIXN5c3RlbV91bmJvdW5kX3dxIHx8ICFzeXN0ZW1fZnJlZXphYmxl
X3dxIHx8DQo+IAkgICAgICAgIXN5c3RlbV9wb3dlcl9lZmZpY2llbnRfd3EgfHwNCj4gCSAgICAg
ICAhc3lzdGVtX2ZyZWV6YWJsZV9wb3dlcl9lZmZpY2llbnRfd3EpOw0KPiArCXN5c3RlbV93cS0+
ZmxhZ3MgfD0gX19XUV9TWVNURU1fV0lERTsNCj4gKwlzeXN0ZW1faGlnaHByaV93cS0+ZmxhZ3Mg
fD0gX19XUV9TWVNURU1fV0lERTsNCj4gKwlzeXN0ZW1fbG9uZ193cS0+ZmxhZ3MgfD0gX19XUV9T
WVNURU1fV0lERTsNCj4gKwlzeXN0ZW1fdW5ib3VuZF93cS0+ZmxhZ3MgfD0gX19XUV9TWVNURU1f
V0lERTsNCj4gKwlzeXN0ZW1fZnJlZXphYmxlX3dxLT5mbGFncyB8PSBfX1dRX1NZU1RFTV9XSURF
Ow0KPiArCXN5c3RlbV9wb3dlcl9lZmZpY2llbnRfd3EtPmZsYWdzIHw9IF9fV1FfU1lTVEVNX1dJ
REU7DQo+ICsJc3lzdGVtX2ZyZWV6YWJsZV9wb3dlcl9lZmZpY2llbnRfd3EtPmZsYWdzIHw9IF9f
V1FfU1lTVEVNX1dJREU7DQoNCkJldHRlciB0byBPUiB0aGlzIGluLCBpbiB0aGUgYWxsb2Nfd29y
a3F1ZXVlKCkgY2FsbD8gUGVyY2VpdmUgdGhlIG5vdGlvbiBvZiBhbiBvcGFxdWUgb2JqZWN0Pw0K
DQoNClRoeHMsIEjDpWtvbg0KDQo+IH0NCj4gDQo+IC8qKg0KPiAtLSANCj4gMi4zMi4wDQo+IA0K
PiANCg0K
