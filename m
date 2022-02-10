Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483AC4B050A
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Feb 2022 06:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiBJF22 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Feb 2022 00:28:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbiBJF21 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Feb 2022 00:28:27 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E676FEBA
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 21:28:28 -0800 (PST)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21A5SREO022333;
        Thu, 10 Feb 2022 05:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=HBUXHmLTMPK4C7UsMkBKwwK11uXjGQviCVF0QIu8zAg=;
 b=PwReKthhEEtf/Fhxd/WAsDBUxb4j/ZGwGdBS+AYT8bh/vr/PNlswjOAYq+GWJymIaXNc
 AMNWu4/NQJN5gfhLNptkWbt8os90MO5XR2EQ4C5zqpkQdZhj0ET9BN/d0SadiB2It99l
 M2z4MvAKrrnFg1QntL4UERXEiGVErxt6uVSWTHMAM2i6TaL/DWGBdFtnEKJJ4sEzl1iU
 2H1CQAcwqln0P6FMBkxCGeB2Iv+l4zp3tkJWJAm5uDgHsXtsLJKD9qNDh8CWEGds9Tft
 cmTXGDwFaTDIeZAGOmEh0S4L9UMzKDemf1c0dkzJoykidONZShh7aJ/mJ4XO2/AXr9LD gg== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3e4vk9800t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 05:28:27 +0000
Received: from G9W8453.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.216.160.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2353.austin.hpe.com (Postfix) with ESMTPS id 875AF86;
        Thu, 10 Feb 2022 05:28:26 +0000 (UTC)
Received: from G9W8453.americas.hpqcorp.net (2002:10d8:a0d3::10d8:a0d3) by
 G9W8453.americas.hpqcorp.net (2002:10d8:a0d3::10d8:a0d3) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Thu, 10 Feb 2022 05:28:26 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (15.241.52.10) by
 G9W8453.americas.hpqcorp.net (16.216.160.211) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23 via Frontend Transport; Thu, 10 Feb 2022 05:28:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frtzLeqgOK4qdf+4aRomSO7e4z7nbS7DW7RvX2jpBK4DkHGlE0vqfMmlLiEIrz09I/Ldp3+E8j+6NbglLPWfrp1q+fhT2yBY2joz5Jr6SXWO+96bgQPD/T/zceUzgFuCnLLYP5NP5cpj329+6PcHHo1iQTTuuWcjPDvf0GyVPhAV5SvEsagyJM8QjB499oO9Aq1nWqkWfk9Ja79Pw7XSFD7xIhwas9e2Y8Z48Te26Jq+6fXSxNnxJdV37bftPIc2tmV8v38JODjF2fwIySSXlSQ6E1aGZGAU2c85vZCksDPW+GgIs77mP6pLTXqx0Nd1O0oedLtRXB1oEY1gsw+sEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBUXHmLTMPK4C7UsMkBKwwK11uXjGQviCVF0QIu8zAg=;
 b=jgqjN893sH4Ldqh8NNqxXH256bbqEHhBIHcAftPcbfnXHRgcMFuzJZG5ESG2EXA8qZmyqg0zrJ7BY6MNE2nKs6KmgwFkwjn9YhBFJSQTVZjeLBa21UYC0WD7vF6EW/G//wyZawn+u3bqY0JLv0qDN3Bz9DUwa3FPs/Pc26qzP8+X5icWMHQctCmSgJFc5nkqN4ZXxMS1P3j8zI0QK3L8j4jgiapNQEuxJlJtQcwTCRT2PkRftO30U9eo7igtnycQGivgVQIp96bvciD1HRCAbwYp0WPIwoOia8fYDHpui2ab9FxOZinpCWtjY45Bn92x0ZVBHxaml3FSgM9LgPa15w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:153::7)
 by PH0PR84MB1501.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Thu, 10 Feb
 2022 05:28:24 +0000
Received: from PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9128:1766:2075:2033]) by PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9128:1766:2075:2033%8]) with mapi id 15.20.4951.014; Thu, 10 Feb 2022
 05:28:24 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Christian Blume <chr.blume@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: Soft-RoCE performance
Thread-Topic: Soft-RoCE performance
Thread-Index: AQHYHi8NFDC8LE0TQkaoT5yscukiFayMNE1ggAAMlbA=
Date:   Thu, 10 Feb 2022 05:28:24 +0000
Message-ID: <PH7PR84MB148879A6AEDC6BFAB2FD44F1BC2F9@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
References: <CAGP7Hd6PAYcX_gMMh8jbpezeSSWQxqDrYwxEq1N-zjgT7563+g@mail.gmail.com>
 <PH7PR84MB148872A4BB08EAFECCFF6B01BC2F9@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <PH7PR84MB148872A4BB08EAFECCFF6B01BC2F9@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcf415ed-6b5f-467e-d6c6-08d9ec5628be
x-ms-traffictypediagnostic: PH0PR84MB1501:EE_
x-microsoft-antispam-prvs: <PH0PR84MB1501852093955EFF42E14ECDBC2F9@PH0PR84MB1501.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gayxl1y3wYXgQ3FTWkOmj/A/LTYSa9lgC03CD2wfj19nlqwuAKstDUhpL4kk0iysDnQvctsG/ctMObAy0GsWGzFxcmloFi0wns4tXS8k0inaBmG+Y/zYd2xnpMNYxqiJjjxJT5e9jKRZy9M3eq89O2ejdWh6aDawbufcJ0yldQBEz6wzaAkuN2Zc6ZINTnbFVJUO82DvtEyxr84s1bH/lpLKpi+cl/dzCP1ukkFGZp4g7qe8brGuKxGfMg+HXGp67zCjG+/LyMnU8CwSOziVG7453AKuI7boBJSdPuIDxG6kQdMsgH4I3XWPnueI31j72/ABxFiFnpDiWVd5dvzZ8R9kXwioBgrzIl7aOcc3Hv1WMK8vp41pgdE8AUWqtXSa9ZvtGYGNArVWnKt8BuCaOeDbswYbGnaW0RVoqSwt184sk1zYhs024QSNbdM0Mq00O4FR+xRBWt8HrFdSYLYXBPKS/uIiigQ2py1FLAqB4HQhgMAd07cqmnFH7SG7NhDKwTa2VpcD85kSSs4dd4ac10r4aNuInA+8yIHYVQvBETHekCp9u9xbhA3wk41jHeiYhAeyAVRNyZIoZOiC0LXMCg2iRyAD6fHchKTZat1AXS2NoG0tWltPPDKfdCbbz8eHskW7tQSncTL2lHLqPx7FLRKlJ8Z2nYjU+zhyAEWd2iVGA4k8jhC79kTuOULEmFhKtdHCfC+lYp9lllMsS29xzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(7696005)(122000001)(8936002)(8676002)(3480700007)(82960400001)(110136005)(316002)(508600001)(33656002)(53546011)(83380400001)(38070700005)(66556008)(76116006)(55016003)(66476007)(6506007)(186003)(64756008)(5660300002)(52536014)(9686003)(38100700002)(66946007)(2906002)(71200400001)(86362001)(66446008)(2940100002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGpubmRIQ054MFdybFlpV29mRFZLR1plOXFxUVUwbnFCazFsbWFiUlhGWnhh?=
 =?utf-8?B?NGU3RkdXakg3SUhLZ2lNWlJhR0F5SU1wc1VIRkpHTGVuM1c5RkdFZ2hFTlNI?=
 =?utf-8?B?UEM3MDRPOW9sYUI0bm55TXQvWEI2bjAvZnVsYlJXcE9zU1NYVFcyb0s2N1Y2?=
 =?utf-8?B?dVFSNGZOUERRZnJ5MEtaQ0lOVDRZZ2ppOWkvU0RNdlJRVVNGQlRnNGs3YjY2?=
 =?utf-8?B?YWc1S2FldG1ldDMyUWZ4TTJrNzlvcUJUT2NnVEcxSUl0OVdualVmZ0Z5aWZs?=
 =?utf-8?B?TUdPcGxJbnNOWWVaUmJkUjlUZFZmNFJQYVQvVWtGTXR1S0w3QUxiL21tQ1Rp?=
 =?utf-8?B?TTJySjI4OTVXNHNPVlJNOGkyemI2aTVHNEQzT2lQRUswdk9MdnVnem5CM0hO?=
 =?utf-8?B?bnhpSkltbGhOYnprVEZZMXJGUlJ4TEpHTWk3YlVnT2NCZXdSSzgzT2NsVE54?=
 =?utf-8?B?S3hra1dQSnB4VWZtZVpwRmFYdTFBNEFJbW1xRjNMMEt2OFVhcWpIS2YzdDUy?=
 =?utf-8?B?T1ZVZ09yajZsSEc5enJDSk84ZWFlOXlnZjN4My9KUUp2UGFiRWFkTDZpWmha?=
 =?utf-8?B?LzhuTFc2ZVZTMnNhcjFmSElTSlM1RjNOWjhLOHkxdDlUcVJXaWx4eDRSUGtp?=
 =?utf-8?B?bVdQeTFyZUdxL3ZMUGw3RWlBNVZlL1RqSnIxVGlwZVZBYjdiV1A0TmVWSEdU?=
 =?utf-8?B?UXIydlpTaTZSMVI0SW9oNlVIMWIvbEtsdERaL1czbWk0TVl1TElJZUZBL2Vu?=
 =?utf-8?B?cE1FZnZNRzlUV0h1LzN1YVJPbUVNWE9Jd1FtMVNJTUg4YVNhRmRwVi8weC96?=
 =?utf-8?B?YUhKWStwUlAxVkVrUm1Xc2NNU2x0T3d5QTkvS291SnlLZ2p5V2FYeWM3U282?=
 =?utf-8?B?Y1JlODRRVXlGOVl0cVlJVTYvUU5nSlVHYzhZdnJiL0tpNGhTaWFuMGRpaEVX?=
 =?utf-8?B?Q2dPTlY2SkJadmZBanZXd2RuanVHZEwwaSt2SnFLeiszZmo5NmdmVEJ4ODF5?=
 =?utf-8?B?L0h2ZkZaaUQ3eTlqQ2dTK3RlSzJCVWNXOEoyOWx1QnE5RVBMVUkwS2g2RlpL?=
 =?utf-8?B?S3kvamxlVVpEOXBIcmVEYU5rTTBrdWhOdWEzMHY4L3dnYkd4WlVxeHBRK09v?=
 =?utf-8?B?TVlLbDRYc3lNTUJERXpiY0htem5XcEtmY3lORm1zU3YvV1E1VTlSdmlFL0Jp?=
 =?utf-8?B?eWZjWFcvSEhhc2prNmNieUlrNFhoc1BFaXo0WktqK3BUL1dINDh0bXhRYVNl?=
 =?utf-8?B?YlFkTE15QXFyVE5QcFdQbnNhbTB6T0IrakZyZnYvVFRtMmZJanRsTmRsL0g5?=
 =?utf-8?B?M1hlTkQ0ckFIbkpXc2kzdzM1MkxSdXB6VmIzNXdrK3NjNDBtVGNIVTVPdktO?=
 =?utf-8?B?S2lWWURHUHZOUEE0NTUrcTlmSjZlcHRIN3Bnbkt4REZYMHcwWlRvV0dvWGx5?=
 =?utf-8?B?SjJqclhDMzlTelJJUXRRemJUMjZJUEhYY09mc2tXdlJBZXpKaUIvbjV5VmpL?=
 =?utf-8?B?TjNzeVI1dUpId29VQTB5QmhLTVBtUkdRQ1BMYzBDTFJoREdKRFZSRThFTU9s?=
 =?utf-8?B?M0NpcGFYVGRFMW94ZmVVTG11U0pzRVFVeGdxTFF1dmJPY2w5cHdhYVpaTjZS?=
 =?utf-8?B?TW8ybU9iMDVtSWtBT2E2OHZLQ1huSEdIWkRhNGVWbGhHb3ZCa05tajNxRUV4?=
 =?utf-8?B?ZGRXZGZkcW9oV3BTOWxRLzJ6eHV0bnZva3dKcDFaZDJSWE1WOUhhb05ZRnRW?=
 =?utf-8?B?eVFjaHFBc1F2ZjNyL3FYYjRSZDVSUG1ZMUpwRXJ4bEtvNFdpN3c5MEUyOVpI?=
 =?utf-8?B?Z3hPcFhHMjZmemd2ajNQSmtBbGtyU1dsQVFMMDlZbW5jRnJsRlJxUDlva0Iz?=
 =?utf-8?B?dm91QlRlSkwvdWlpQ2dRWjlCSzRrU1dZakNJSXA5UnpjalNLWWxQTHhJYWR1?=
 =?utf-8?B?Ym9rbXpjaW1sTEtRR1Z2QWdMcFQ3WEZwTmFlQW5CK0I3UDhKdzBBTHBFbFBm?=
 =?utf-8?B?ZUNYUmNZSitRWDVGMm5NVFZrd3FJSEJERWRBblNmbmhNMHJGQnBaWWRvRUZK?=
 =?utf-8?B?VGM3V1ZzVGRHZ3g1SDhJKzFNZlQrdG52bEVtTDlKclRhdzk2V21wZTdVNE1W?=
 =?utf-8?B?TlhCZlRpS2tYSzJweFU1ZTVzRlZIZDBNcVN5bm56L0p3UVpsVE83R1hrSGJh?=
 =?utf-8?B?bWl2YjFWZzVDTnVhVC9pa0dpY2pZcUt4TXVPWDE2NkxXNWNwY0o1VHdKK295?=
 =?utf-8?Q?T7bMsCBrviAzEwMWCeudnxok7VuKv0fI+tsUX2zI3o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf415ed-6b5f-467e-d6c6-08d9ec5628be
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 05:28:24.3167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: loHeRvXUTh1efr7xR2o7feByO0PR3zX+0ByFNIZD8+DoWQd6ODaC29Dpz08NpS3+3xWsXDliSiHeSedy7qCQAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1501
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 8-JYlELwu_-FrgtW3PBJx2q2c-nv_9vY
X-Proofpoint-GUID: 8-JYlELwu_-FrgtW3PBJx2q2c-nv_9vY
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_01,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=798
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202100030
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

U29ycnkgZ290IGRpc3RyYWN0ZWQgYW5kIGZvcmdvdCB0byBtZW50aW9uIHRoZSBvdGhlciB0aGlu
Zy4gSWJfd3JpdGVfYncgaXMgbGltaXRlZCB0byBhIHNpbmdsZSB0aHJlYWRlZCBwcm9jZXNzLiBJ
ZiB5b3UgcnVuIG1vcmUgSU8gdGhyZWFkcyB5b3UgY2FuIGltcHJvdmUgcGVyZm9ybWFuY2UuIEli
X3dyaXRlX2J3IHdpbGwgbGV0IHlvdSBoYXZlIG1vcmUgdGhhbiBvbmUgUVAgYnV0IGl0IGhhcyB0
byBydW4gb24gYSBzaW5nbGUgY29yZSBzbyBpdCBkb2Vzbid0IHNjYWxlIGFsbCB0aGF0IHdlbGwu
DQoNCkJvYg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUGVhcnNvbiwgUm9i
ZXJ0IEIgPHJvYmVydC5wZWFyc29uMkBocGUuY29tPiANClNlbnQ6IFdlZG5lc2RheSwgRmVicnVh
cnkgOSwgMjAyMiAxMToxMyBQTQ0KVG86IENocmlzdGlhbiBCbHVtZSA8Y2hyLmJsdW1lQGdtYWls
LmNvbT47IFJETUEgbWFpbGluZyBsaXN0IDxsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZz4NClN1
YmplY3Q6IFJFOiBTb2Z0LVJvQ0UgcGVyZm9ybWFuY2UNCg0KQ2hyaXN0aWFuLA0KDQpUaGVyZSBh
cmUgdHdvIGtleSBkaWZmZXJlbmNlcyBiZXR3ZWVuIFRDUCBhbmQgc29mdCBSb0NFLiBNb3N0IGlt
cG9ydGFudGx5IFRDUCBjYW4gdXNlIGEgNjRLaUIgTVRVIHdoaWNoIGlzIGZyYWdtZW50ZWQgYnkg
VFNPIG9yIEdTTyBpZiB5b3VyIE5JQyBkb2Vzbid0IHN1cHBvcnQgVFNPIHdoaWxlIHNvZnQgUm9D
RSBpcyBsaW1pdGVkIGJ5IHRoZSBwcm90b2NvbCB0byBhIDRLaUIgcGF5bG9hZC4gV2l0aCBvdmVy
aGVhZCBmb3IgaGVhZGVycyB5b3UgbmVlZCBhIGxpbmsgTVRVIG9mIGFib3V0IDQwOTYrMjU2LiBJ
ZiB5b3VyIGFwcGxpY2F0aW9uIGlzIGdvaW5nIGJldHdlZW4gc29mdCBSb0NFIGFuZCBoYXJkIFJv
Q0UgeW91IGhhdmUgdG8gbGl2ZSB3aXRoIHRoaXMgbGltaXQgYW5kIGNvbXB1dGUgSUNSQyBvbiBl
YWNoIHBhY2tldC4gQ2hlY2tpbmcgaXMgb3B0aW9uYWwgc2luY2UgUm9DRSBwYWNrZXRzIGhhdmUg
YSBjcmMzMiBjaGVja3N1bSBmcm9tIGV0aGVybmV0LiBJZiB5b3UgYXJlIHVzaW5nIHNvZnQgUm9D
RSB0byBzb2Z0IFJvQ0UgeW91IGNhbiBpZ25vcmUgYm90aCBJQ1JDIGNhbGN1bGF0aW9ucyBhbmQg
d2l0aCBhIHBhdGNoIGluY3JlYXNlIHRoZSBNVFUgYWJvdmUgNEtpQi4gSSBoYXZlIG1lYXN1cmVk
IHdyaXRlIHBlcmZvcm1hbmNlIHVwIHRvIGFyb3VuZCAzNSBHQi9zIGluIGxvY2FsIGxvb3BiYWNr
IG9uIGEgc2luZ2xlIDEyIGNvcmUgYm94IChBTUQgMzkwMHgpIHVzaW5nIDEyIElPIHRocmVhZHMs
IDE2S0IgTVRVLCBhbmQgSUNSQyBkaXNhYmxlZCBmb3IgMU1CIG1lc3NhZ2VzLiBUaGlzIGlzIG9u
IGhlYWQgb2YgdHJlZSB3aXRoIHNvbWUgcGF0Y2hlcyBub3QgeWV0IHVwc3RyZWFtLg0KDQpCb2Ig
UGVhcnNvbg0KcnBlYXJzb25ocGVAZ21haWwuY29tDQpycGVhcnNvbkBocGUuY29tDQoNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlzdGlhbiBCbHVtZSA8Y2hyLmJsdW1l
QGdtYWlsLmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDksIDIwMjIgOTozNCBQTQ0K
VG86IFJETUEgbWFpbGluZyBsaXN0IDxsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZz4NClN1Ympl
Y3Q6IFNvZnQtUm9DRSBwZXJmb3JtYW5jZQ0KDQpIZWxsbyENCg0KSSBhbSBzZWVpbmcgdGhhdCBT
b2Z0LVJvQ0UgaGFzIG11Y2ggbG93ZXIgdGhyb3VnaHB1dCB0aGFuIFRDUC4gSXMgdGhhdCBleHBl
Y3RlZD8gSWYgbm90LCBhcmUgdGhlcmUgdHlwaWNhbCBjb25maWcgcGFyYW1ldGVycyBJIGNhbiBm
aWRkbGUgd2l0aD8NCg0KV2hlbiBydW5uaW5nIGlwZXJmIEkgYW0gZ2V0dGluZyBhcm91bmQgMzAw
TUIvcyB3aGVyZWFzIGl0J3Mgb25seSBhcm91bmQgMTAwTUIvcyB1c2luZyBpYl93cml0ZV9idyBm
cm9tIHBlcmZ0ZXN0cy4NCg0KVGhpcyBpcyBiZXR3ZWVuIHR3byBtYWNoaW5lcyBydW5uaW5nIFVi
dW50dTIwLjA0IHdpdGggdGhlIDUuMTEga2VybmVsLg0KDQpDaGVlcnMsDQpDaHJpc3RpYW4NCg==
