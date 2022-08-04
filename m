Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF9F5896B6
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Aug 2022 05:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbiHDDsP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Aug 2022 23:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiHDDsO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Aug 2022 23:48:14 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD18B33376
        for <linux-rdma@vger.kernel.org>; Wed,  3 Aug 2022 20:48:12 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2743K5Rc023192;
        Thu, 4 Aug 2022 03:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=Vol3+CLJdJExvwOE6uj8OoJY8OXh6O+0s4YPZvP1ljI=;
 b=TCNR/VUSy4kCOnQzLGxl1D4E9HvRGu0J56Gac16JAWX8ke+e+ERUD9i2K0VSBuPDifpT
 9G7+uzcl/N3TCITD0qtHkW7g9cN+aHsZGefuRDdWM0jTF20JRKGRLLZiQHG6rjRiK9Pg
 usS/R9n4s2kTPDa+kxs+KHeXt5wxUzGm+jyuAS0QY4BUM++vxY+WT9PlLjnUPyO1yh/h
 xyTyyexxYHWeP+br2FvDwWmRNpjTKmHdFCAZ/jYTCRN2/vTeVDaSWB0BG1HgpNwpkGwQ
 lUjkUKsYoyxjrxOHDWJW/avm8M4wg/UUccP3aCvimFgybpKy/gzBH+8qnZgYT9VtvDjv 5A== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3hr63sr4r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 03:48:08 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id D03D9D2E2;
        Thu,  4 Aug 2022 03:48:07 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 3 Aug 2022 15:48:02 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 3 Aug 2022 15:48:01 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 3 Aug 2022 15:48:01 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 4 Aug 2022 03:33:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5B57YtvjhnTCmDmuWzPQMsQF4pCGUNseaFrfMapXxBh+9uixnRjpPc6c8CcPpXv6OKmp9Nhnqtf193/87bhZGa0cU4mdluR95BQkWUPw5U84cl8Sp55Cp769mcrNEhLmk2kCU+5geIzDJvPv/WMyMaYtNTif/0ruAS2Tb8q0ZkBH77GMIXJkl9WAi2uhE4V/XRtVFt/orcSR22l7yVGYlZMwTd509Mqen+K5PqsRPAPe/5Yo5bUsUVQZVW4DetTHW6Qim8XaiK1oqW6KWv1ouCHVStuZPH+ni3uVwcc2U593tqKGEL5GSuRxawNU+adiv0J7+XUtsf5K0Bb1Skbfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vol3+CLJdJExvwOE6uj8OoJY8OXh6O+0s4YPZvP1ljI=;
 b=KCPOoexLpT9ftsGbZiRnHHd27p3fRvVqLZYR3fiWhyDcT9s2eArDFjepdLTwlK57TTLUnOLbKDFHj7dkf6tQI7DYeqZU6sg4K97zdBZfWRjoKoOc0CKe0VFCIpUb2mC60Mgk0RIXPuakcEVcczvFFXPQ+LixtaHVxoRdpfUcxCa7W2trnXVAmt9KaNwL7lk2nHqkScGwbPtg7EhQtLOdK4lA9PukwnlxJ7avL5gj6lKWRUyTbOKTCdPQBqqeYuGGyMGfLVMOlp8tRomKUjEHe/nPNW9AUegeTcdq8l8l3gp956q/XJAsVMBAI9sfSbzKDI2cz0bLyAHDGSnz8UuLng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by PH7PR84MB1415.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:151::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Thu, 4 Aug
 2022 03:32:59 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4ce9:c60a:8e9:34a]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4ce9:c60a:8e9:34a%5]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 03:32:59 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "jg@nvidia.com" <jg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "Hack, Jenny (Ft. Collins)" <jhack@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v3 for-next] RDMA/rxe: Fix error paths in MR alloc
 routines
Thread-Topic: [PATCH v3 for-next] RDMA/rxe: Fix error paths in MR alloc
 routines
Thread-Index: AQHYp4pOGx9gp1hcoECPCm9sNdATR62eCMqAgAANzPA=
Date:   Thu, 4 Aug 2022 03:32:58 +0000
Message-ID: <MW4PR84MB2307C7D97E5A0E1067FA0FC4BC9F9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220803224100.5500-1-rpearsonhpe@gmail.com>
 <4ce8802a-b62b-a7eb-c972-976c4c1c8c75@fujitsu.com>
In-Reply-To: <4ce8802a-b62b-a7eb-c972-976c4c1c8c75@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 134e83e8-2deb-49f5-7796-08da75ca071d
x-ms-traffictypediagnostic: PH7PR84MB1415:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +VU46v9FTpn4n/ZJDowyZPr+mm4wdLi7w5QVCbU2cCagDIPY51Q9a2zAecPq3uTFPH5q9EptLSB7voSyuWwtkSSWjHlQMA+VODmmc35wAN5mdecdoJwniIV2uRIjXr+gsTZgnGFLbG2y4pkAheqZk9v/I9CMnE2BWRmQcrl1RpAKrPc+qXDLbKqSgPD3WlHMRON+08PrdG9smPfbQsjBUmsWNw3DzhQ2pQvbbt31G7fppMDlIekdLFosOStuWxQu3204C5HUoYIGJ1QiFiYsMIt/HzWLXhh6UVsayCwWLenY0TNot1iMWd/C8MeS8OSv+1DzLdJELWLE9AtM4YpXgKHpD/zThe3bMMbRBpcepNtgJFh9nfiQrG7UVRB/t448BJb/UDj4r9mEYRfHp7glkm4l+tWGPEXn5ckswFzkmbsmpMEOUMzZeKmzcLQMozJFrRCb/a6sbnOi8E433MM29QAhomsfDlMp/eNVloWjp5fnY8Cdl1toNuRx2VFDj/4r3kb3yE0wu1lT3Fly1jmsEzq5YA3R+QwEmzyGDtbazGF2B4CC5/uT2YfL1p0vDUMTyuWGcwghA2xPDH9277AjrSq1tQkqd5uVBKZDIMSSJMIuBIZZv29yKsbY/m3fxdoT3BN3Q+k+ffHVCafxdO7/8cVPJLjK1lC91q3ZPvOHllVecnPBzHIBSmHVIV7CHgr4pGudu/sWY0pqOtPuTf3mKPCM5w/RFHpTTzwmtGRnASgI5hDhbApZELWlnhF4KBrUigtHxafKuRLeiubB0VGmJGI3pJkTyl8Sh7Afuj2J8Eqi09VVYfNni7WCOtFFvMpVgOkFGqY27tKdDXLVvRFupA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(376002)(39860400002)(346002)(9686003)(52536014)(26005)(38070700005)(478600001)(5660300002)(71200400001)(86362001)(76116006)(41300700001)(66446008)(66946007)(66556008)(966005)(64756008)(8936002)(8676002)(82960400001)(66476007)(55016003)(110136005)(83380400001)(53546011)(2906002)(316002)(33656002)(38100700002)(7696005)(6506007)(122000001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGZSaHBBSHVxOTFabThRMHlaVVdCckhyS3NxWkJlL0RKSjRXd0JXUVlCRkVV?=
 =?utf-8?B?Zi9sUGd2bGdhSG5xRWhnYk9BdTJJVENFZ0J4ZytEcVBmWTd0RlFhaDBGUlpm?=
 =?utf-8?B?Ym81OEs4TkMyNG90NEllQ09Dc2wvUWMrdFBKOTZYMHJITjV4V1lMdXh6dFM5?=
 =?utf-8?B?TGF4dExBeUVDajgxbHZJTGl5YVd0eXU1empkR3hjblppOFdNMkRPN2w2WWhI?=
 =?utf-8?B?UjVPMG5CNzJKZWtuQ2pHS0ticGRGV2Y5dGs2R2VwTnQybVZPbFlQb1RFUzQy?=
 =?utf-8?B?L1N1bFdMa1p5YkFJcEFabmR4R0F0b1cyNHNjUjhWcTZhcjJTRlN4N1dQT1lr?=
 =?utf-8?B?dHptbWtScTV2RFVQMnJ3Tmo3VnJjcXFjWGZsZFZPVWYvSXQyYTJIYjNDMEU5?=
 =?utf-8?B?NWZXRzJOM0F2U0tteHREOXEvVmtTM1dvZldRVVNoeXZwckV5eWxiQzVrUGlJ?=
 =?utf-8?B?cUcrYVUzZEJvN3FyRkgxWVI4ZlQzaEFGVTVqK3I4UDlPM3NXY25WUStEdXF0?=
 =?utf-8?B?dzVic1VpbEo0QjZFK2RORHpwckc1WldRaksyYVpza2NXN2dNQlUxSnYvZWR6?=
 =?utf-8?B?WVFoWmY2dnJob0dPTzFwQU1abVFQenN2Z1lWQTc2anVTTDZ3QUdvZkhxSnJ1?=
 =?utf-8?B?OWh3S3B1RjBTeDc3WEw5SXp1L3BSSmtPdHNhWTF2Z25xYW9yZ1lacllwRnlj?=
 =?utf-8?B?eExEa1YvTE9aMVljaVRGQVc1dkhydmliN3RWaEhCWTVaU21yUzZ0U1F5bngy?=
 =?utf-8?B?YmhaWGVLMmxKM1JNYVNJcjk2WWNQcW1KRVFSL0lwYnZwSFA3NW4xdkVvR3Uy?=
 =?utf-8?B?bVFReWxoZDZ4c2dVSFlmMTE3b0RKMUwxNjZRZ1dJcmVBYnFaejUvOGpYQ2pY?=
 =?utf-8?B?TVV6LzNnVlZvbkdFV1VTWWZHNVpiU3d6bCtFNk9FZUIySkhUaFhkTEZBRlJX?=
 =?utf-8?B?dGUwNVptZC91WGRJT1ZhWG1IUm9BUXgrWFRLUGdhMTM4d2FQRzd0WWVtTTJy?=
 =?utf-8?B?ZW16d2xCNXJ4ZnBXRHZnTVd0RzBwOFpxMkxSWGd1UHY0c2UvTHBoNCt2VXR1?=
 =?utf-8?B?TDcrSVR4VFZqbTJhUEt5MU9mcjV1Uit4Y0xQNEZHMDFubHphVHJIMmIrbko2?=
 =?utf-8?B?Nmh0bU0xbEpoVnFPWVhJR3lDQ1l2bXdURVUvaW9MeWtUeW9sSC9MRld0S0kv?=
 =?utf-8?B?eStaRldybm5kSWxQUVVjQVppcHhOZ3QwQzZqS3BjZEozcEphYnZtdFROblRX?=
 =?utf-8?B?NGd0WnZpT3pWUVlpRmMwN1VSRVdodjNFeGxYLzNBZm5UKyt5SEg1c1g2RG1q?=
 =?utf-8?B?Zk43dFJ3emN6UW5DVndnazBMRkVxcFg4NFJkQ2txelo0SmorNDhROWJmVktY?=
 =?utf-8?B?T2ZIcjN1Q1ZscFhoRXl1THBCMmoveUM4RnJYZ1NBK1k4anlxZ0tIbHVNbW9m?=
 =?utf-8?B?WkkxODVoR0R2WEJyWjQzVVdsQnViVGd6bjV2b3IxdmRSMTl5bWdNN1NHaWpv?=
 =?utf-8?B?akx5NGFncjkzU3dUYmF3U0djNndsV0piUHl4NXVBYks3SXFOOGd4YzdkcUxE?=
 =?utf-8?B?eThoRnNzNktheE9MZm5neWdFNlliaWRMZUVpU08vdWt6SXhVNzdFL0hoQVc0?=
 =?utf-8?B?SU5nNkk5UHI2R3ZaQ3M5VUZDZXh1cEtCOXRiczBZM0xxOVpqVGlIb2dNaEhX?=
 =?utf-8?B?WDgwRHJsZVZKRk5kZWkrRGZSdTBIdjFmVURpc3Z5cmdlaWM1cnh2Y2FGajEv?=
 =?utf-8?B?VDZzemFLcWNoSWI4YkZTdnZSdjBPRlIyTEFsN2NVbEZJbzhkQ0JjZW10d3JW?=
 =?utf-8?B?MWc5K1dXZjIrbGFBRllkRkVoZTI0WHRaQWY0dGZEaUdIaFZqelRZZHFRNkNK?=
 =?utf-8?B?SVlZK00zZ0ZtMlBVT2xkYTk4WW1xYXVsOUJ5c3dhZU1VZFp3WWZwWnpBa3Uw?=
 =?utf-8?B?S1FhTmoveVZGY0ZaNVhmMk8xTHkyd0x5bU9aaTBVWUhnejBQKzVaQkRzcGF5?=
 =?utf-8?B?YUw3anVUbDcvejhzMHhXYkg3SG5mV3RSTU9kVjY1Q24yUktDb3RBY3g2eEFm?=
 =?utf-8?B?K0NkUUdZK3ZBMlJUY3Z1Wi9xc1c0V1BEUG9lKysreTIyajQ3K3hjMHExMlZh?=
 =?utf-8?Q?44OJO6R0YXFePSrkhhJaym6I1?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 134e83e8-2deb-49f5-7796-08da75ca071d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 03:32:58.9092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R85Vffdl08SLUlqfNvWlLFyAD7OtuvUK9w9v6pPH0ITtUIx+OJOsSAkVusoegAr3sCebtfZyE17zBUTV2ixp6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1415
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: Zk4jR58eDNHvrl0mvlzSYJl5Jlf_WAEB
X-Proofpoint-GUID: Zk4jR58eDNHvrl0mvlzSYJl5Jlf_WAEB
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_07,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1011 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2208040016
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SSdsbCBsb29rIGF0IGl0IGFnYWluLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogbGl6aGlqaWFuQGZ1aml0c3UuY29tIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+IA0KU2VudDog
V2VkbmVzZGF5LCBBdWd1c3QgMywgMjAyMiA5OjQzIFBNDQpUbzogQm9iIFBlYXJzb24gPHJwZWFy
c29uaHBlQGdtYWlsLmNvbT47IGpnQG52aWRpYS5jb207IHp5anp5ajIwMDBAZ21haWwuY29tOyBI
YWNrLCBKZW5ueSAoRnQuIENvbGxpbnMpIDxqaGFja0BocGUuY29tPjsgbGludXgtcmRtYUB2Z2Vy
Lmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgZm9yLW5leHRdIFJETUEvcnhlOiBG
aXggZXJyb3IgcGF0aHMgaW4gTVIgYWxsb2Mgcm91dGluZXMNCg0KDQoNCk9uIDA0LzA4LzIwMjIg
MDY6NDEsIEJvYiBQZWFyc29uIHdyb3RlOg0KPiBDdXJyZW50bHkgdGhlIHJ4ZSBkcml2ZXIgaGFz
IGluY29ycmVjdCBjb2RlIGluIGVycm9yIHBhdGhzIGZvciANCj4gYWxsb2NhdGluZyBNUiBvYmpl
Y3RzLiBUaGUgUEQgYW5kIHVtZW0gYXJlIGFsd2F5cyBmcmVlZCBpbg0KPiByeGVfbXJfY2xlYW51
cCgpIGJ1dCBpbiBzb21lIGVycm9yIHBhdGhzIHRoZXkgYXJlIGFscmVhZHkgZnJlZWQgb3IgDQo+
IG5ldmVyIHNldC4gVGhpcyBwYXRjaCBtYWtlcyBzdXJlIHRoYXQgdGhlIFBEIGlzIGFsd2F5cyBz
ZXQgYW5kIGNoZWNrcyANCj4gdG8gc2VlIGlmIHVtZW0gaXMgc2V0IGJlZm9yZSBmcmVlaW5nIGl0
IGluIHJ4ZV9tcl9jbGVhbnVwKCkuIHVtZW0gYW5kIA0KPiBtYXBzIGFyZSBmcmVlZCBpZiBhbiBl
cnJvciBvY2N1cnMgaW4gYW4gYWxsb2NhdGUgbXIgY2FsbC4gU2V0dGluZyANCj4gbXItPmlibXIu
cGQgaXMgcmVtb3ZlZCBzaW5jZSB0aGlzIHNob3VsZCBhbHdheXMgdGFrZSBwbGFjZSBpbiANCj4g
cmRtYS1jb3JlLg0KPg0KPiBSZXBvcnRlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0
c3UuY29tPg0KPiBMaW5rOiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmRtYS8x
MWRhZmE1Zi1jNTJkLTE2YzEtZmUzNy0yY2Q0NWFiMjA0Nw0KPiA0QGZ1aml0c3UuY29tLw0KDQpJ
IGhhdmVuJ3QgcmV2aWV3ZWQgdGhlIGRldGFpbHMsIGJ1dCBpdCBzdGlsbCBjYXVzZSB0aGUga2Vy
bmVsIGNyYXNoIGFmdGVyIGZvcmNlIGluamVjdGluZyBhbiBlcnJvci4NCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMgYi9kcml2ZXJzL2luZmluaWJhbmQv
c3cvcnhlL3J4ZV9tci5jDQppbmRleCA1Njk0MGNmNzBmZTAuLmJmNzJiOTgzNDU3NSAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCisrKyBiL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCkBAIC0xMjcsNyArMTI3LDcgQEAgaW50IHJ4ZV9t
cl9pbml0X3VzZXIoc3RydWN0IHJ4ZV9kZXYgKnJ4ZSwgdTY0IHN0YXJ0LCB1NjQgbGVuZ3RoLCB1
NjQgaW92YSwNCg0KIMKgwqDCoMKgwqDCoMKgIHJ4ZV9tcl9pbml0KGFjY2VzcywgbXIpOw0KDQot
wqDCoMKgwqDCoMKgIGVyciA9IHJ4ZV9tcl9hbGxvYyhtciwgbnVtX2J1Zik7DQorwqDCoMKgwqDC
oMKgIGVyciA9IC1FTk9NRU07IC8vIHJ4ZV9tcl9hbGxvYyhtciwgbnVtX2J1Zik7DQogwqDCoMKg
wqDCoMKgwqAgaWYgKGVycikgew0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpYl91
bWVtX3JlbGVhc2UodW1lbSk7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biBlcnI7DQoNCg0KDQoNCj4gRml4ZXM6IDM5MDJiNDI5Y2ExNCAoIkltcGxlbWVudCBpbnZhbGlk
YXRlIE1XIG9wZXJhdGlvbnMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBCb2IgUGVhcnNvbiA8cnBlYXJz
b25ocGVAZ21haWwuY29tPg0KPiAtLS0NCj4gdjM6DQo+ICAgIHJlYmFzZWQgdG8gYXBwbHkgdG8g
Y3VycmVudCBmb3ItbmV4dCBhZnRlcg0KPiAgICAJUmV2ZXJ0ICJSRE1BL3J4ZTogQ3JlYXRlIGR1
cGxpY2F0ZSBtYXBwaW5nIHRhYmxlcyBmb3IgRk1ScyINCj4gdjI6DQo+ICAgIE1vdmVkIHNldHRp
bmcgbXItPnVtZW0gdW50aWwgYWZ0ZXIgY2hlY2tzIHRvIGF2b2lkIHNlbmRpbmcNCj4gICAgYW4g
RVJSX1BUUiB0byBpYl91bWVtX3JlbGVhc2UoKS4NCj4gICAgQ2xlYW5lZCB1cCB1bWVtIGFuZCBt
YXAgc2V0cyBpZiBlcnJvcnMgb2NjdXIgaW4gYWxsb2MgbXIgY2FsbHMuDQo+ICAgIFJlYmFzZWQg
dG8gY3VycmVudCBmb3ItbmV4dC4NCj4gLS0tDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGVfbG9jLmggICB8ICA2ICstDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVf
bXIuYyAgICB8IDkxICsrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGRyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmMgfCA1MyArKysrKystLS0tLS0tLS0tDQo+ICAgMyBm
aWxlcyBjaGFuZ2VkLCA1NyBpbnNlcnRpb25zKCspLCA5MyBkZWxldGlvbnMoLSkNCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2xvYy5oIA0KPiBiL2RyaXZl
cnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2xvYy5oDQo+IGluZGV4IDIyZjZjYzMxZDFkNi4uYzJh
NWM4ODE0YTQ4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9s
b2MuaA0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9sb2MuaA0KPiBAQCAt
NjQsMTAgKzY0LDEwIEBAIGludCByeGVfbW1hcChzdHJ1Y3QgaWJfdWNvbnRleHQgKmNvbnRleHQs
IHN0cnVjdCANCj4gdm1fYXJlYV9zdHJ1Y3QgKnZtYSk7DQo+ICAgDQo+ICAgLyogcnhlX21yLmMg
Ki8NCj4gICB1OCByeGVfZ2V0X25leHRfa2V5KHUzMiBsYXN0X2tleSk7DQo+IC12b2lkIHJ4ZV9t
cl9pbml0X2RtYShzdHJ1Y3QgcnhlX3BkICpwZCwgaW50IGFjY2Vzcywgc3RydWN0IHJ4ZV9tciAN
Cj4gKm1yKTsgLWludCByeGVfbXJfaW5pdF91c2VyKHN0cnVjdCByeGVfcGQgKnBkLCB1NjQgc3Rh
cnQsIHU2NCBsZW5ndGgsIA0KPiB1NjQgaW92YSwNCj4gK3ZvaWQgcnhlX21yX2luaXRfZG1hKGlu
dCBhY2Nlc3MsIHN0cnVjdCByeGVfbXIgKm1yKTsgaW50IA0KPiArcnhlX21yX2luaXRfdXNlcihz
dHJ1Y3QgcnhlX2RldiAqcnhlLCB1NjQgc3RhcnQsIHU2NCBsZW5ndGgsIHU2NCANCj4gK2lvdmEs
DQo+ICAgCQkgICAgIGludCBhY2Nlc3MsIHN0cnVjdCByeGVfbXIgKm1yKTsgLWludCByeGVfbXJf
aW5pdF9mYXN0KHN0cnVjdCANCj4gcnhlX3BkICpwZCwgaW50IG1heF9wYWdlcywgc3RydWN0IHJ4
ZV9tciAqbXIpOw0KPiAraW50IHJ4ZV9tcl9pbml0X2Zhc3QoaW50IG1heF9wYWdlcywgc3RydWN0
IHJ4ZV9tciAqbXIpOw0KPiAgIGludCByeGVfbXJfY29weShzdHJ1Y3QgcnhlX21yICptciwgdTY0
IGlvdmEsIHZvaWQgKmFkZHIsIGludCBsZW5ndGgsDQo+ICAgCQllbnVtIHJ4ZV9tcl9jb3B5X2Rp
ciBkaXIpOw0KPiAgIGludCBjb3B5X2RhdGEoc3RydWN0IHJ4ZV9wZCAqcGQsIGludCBhY2Nlc3Ms
IHN0cnVjdCByeGVfZG1hX2luZm8gDQo+ICpkbWEsIGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvcnhlL3J4ZV9tci5jIA0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhl
X21yLmMNCj4gaW5kZXggODUwYjgwZjVhZDhiLi41Njk0MGNmNzBmZTAgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCj4gKysrIGIvZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGVfbXIuYw0KPiBAQCAtNjcsMjAgKzY3LDI0IEBAIHN0YXRpYyB2b2lk
IHJ4ZV9tcl9pbml0KGludCBhY2Nlc3MsIHN0cnVjdCByeGVfbXIgDQo+ICptcikNCj4gICANCj4g
ICBzdGF0aWMgaW50IHJ4ZV9tcl9hbGxvYyhzdHJ1Y3QgcnhlX21yICptciwgaW50IG51bV9idWYp
DQo+ICAgew0KPiAtCWludCBpOw0KPiAtCWludCBudW1fbWFwOw0KPiAgIAlzdHJ1Y3QgcnhlX21h
cCAqKm1hcCA9IG1yLT5tYXA7DQo+ICsJaW50IG51bV9tYXA7DQo+ICsJaW50IGk7DQo+ICAgDQo+
ICAgCW51bV9tYXAgPSAobnVtX2J1ZiArIFJYRV9CVUZfUEVSX01BUCAtIDEpIC8gUlhFX0JVRl9Q
RVJfTUFQOw0KPiAgIA0KPiAgIAltci0+bWFwID0ga21hbGxvY19hcnJheShudW1fbWFwLCBzaXpl
b2YoKm1hcCksIEdGUF9LRVJORUwpOw0KPiAgIAlpZiAoIW1yLT5tYXApDQo+IC0JCWdvdG8gZXJy
MTsNCj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ICAgDQo+ICAgCWZvciAoaSA9IDA7IGkgPCBudW1f
bWFwOyBpKyspIHsNCj4gICAJCW1yLT5tYXBbaV0gPSBrbWFsbG9jKHNpemVvZigqKm1hcCksIEdG
UF9LRVJORUwpOw0KPiAtCQlpZiAoIW1yLT5tYXBbaV0pDQo+IC0JCQlnb3RvIGVycjI7DQo+ICsJ
CWlmICghbXItPm1hcFtpXSkgew0KPiArCQkJZm9yIChpLS07IGkgPj0gMDsgaS0tKQ0KPiArCQkJ
CWtmcmVlKG1yLT5tYXBbaV0pOw0KPiArCQkJa2ZyZWUobXItPm1hcCk7DQo+ICsJCQlyZXR1cm4g
LUVOT01FTTsNCj4gKwkJfQ0KPiAgIAl9DQo+ICAgDQo+ICAgCUJVSUxEX0JVR19PTighaXNfcG93
ZXJfb2ZfMihSWEVfQlVGX1BFUl9NQVApKTsNCj4gQEAgLTkzLDQ1ICs5NywzMSBAQCBzdGF0aWMg
aW50IHJ4ZV9tcl9hbGxvYyhzdHJ1Y3QgcnhlX21yICptciwgaW50IG51bV9idWYpDQo+ICAgCW1y
LT5tYXhfYnVmID0gbnVtX21hcCAqIFJYRV9CVUZfUEVSX01BUDsNCj4gICANCj4gICAJcmV0dXJu
IDA7DQo+IC0NCj4gLWVycjI6DQo+IC0JZm9yIChpLS07IGkgPj0gMDsgaS0tKQ0KPiAtCQlrZnJl
ZShtci0+bWFwW2ldKTsNCj4gLQ0KPiAtCWtmcmVlKG1yLT5tYXApOw0KPiAtZXJyMToNCj4gLQly
ZXR1cm4gLUVOT01FTTsNCj4gICB9DQo+ICAgDQo+IC12b2lkIHJ4ZV9tcl9pbml0X2RtYShzdHJ1
Y3QgcnhlX3BkICpwZCwgaW50IGFjY2Vzcywgc3RydWN0IHJ4ZV9tciANCj4gKm1yKQ0KPiArdm9p
ZCByeGVfbXJfaW5pdF9kbWEoaW50IGFjY2Vzcywgc3RydWN0IHJ4ZV9tciAqbXIpDQo+ICAgew0K
PiAgIAlyeGVfbXJfaW5pdChhY2Nlc3MsIG1yKTsNCj4gICANCj4gLQltci0+aWJtci5wZCA9ICZw
ZC0+aWJwZDsNCj4gICAJbXItPmFjY2VzcyA9IGFjY2VzczsNCj4gICAJbXItPnN0YXRlID0gUlhF
X01SX1NUQVRFX1ZBTElEOw0KPiAgIAltci0+dHlwZSA9IElCX01SX1RZUEVfRE1BOw0KPiAgIH0N
Cj4gICANCj4gLWludCByeGVfbXJfaW5pdF91c2VyKHN0cnVjdCByeGVfcGQgKnBkLCB1NjQgc3Rh
cnQsIHU2NCBsZW5ndGgsIHU2NCANCj4gaW92YSwNCj4gK2ludCByeGVfbXJfaW5pdF91c2VyKHN0
cnVjdCByeGVfZGV2ICpyeGUsIHU2NCBzdGFydCwgdTY0IGxlbmd0aCwgdTY0IA0KPiAraW92YSwN
Cj4gICAJCSAgICAgaW50IGFjY2Vzcywgc3RydWN0IHJ4ZV9tciAqbXIpDQo+ICAgew0KPiAtCXN0
cnVjdCByeGVfbWFwCQkqKm1hcDsNCj4gLQlzdHJ1Y3QgcnhlX3BoeXNfYnVmCSpidWYgPSBOVUxM
Ow0KPiAtCXN0cnVjdCBpYl91bWVtCQkqdW1lbTsNCj4gLQlzdHJ1Y3Qgc2dfcGFnZV9pdGVyCXNn
X2l0ZXI7DQo+IC0JaW50CQkJbnVtX2J1ZjsNCj4gLQl2b2lkCQkJKnZhZGRyOw0KPiArCXN0cnVj
dCByeGVfcGh5c19idWYgKmJ1ZiA9IE5VTEw7DQo+ICsJc3RydWN0IHNnX3BhZ2VfaXRlciBzZ19p
dGVyOw0KPiArCXN0cnVjdCByeGVfbWFwICoqbWFwOw0KPiArCXN0cnVjdCBpYl91bWVtICp1bWVt
Ow0KPiArCWludCBudW1fYnVmOw0KPiArCXZvaWQgKnZhZGRyOw0KPiAgIAlpbnQgZXJyOw0KPiAt
CWludCBpOw0KPiAgIA0KPiAtCXVtZW0gPSBpYl91bWVtX2dldChwZC0+aWJwZC5kZXZpY2UsIHN0
YXJ0LCBsZW5ndGgsIGFjY2Vzcyk7DQo+IC0JaWYgKElTX0VSUih1bWVtKSkgew0KPiAtCQlwcl93
YXJuKCIlczogVW5hYmxlIHRvIHBpbiBtZW1vcnkgcmVnaW9uIGVyciA9ICVkXG4iLA0KPiAtCQkJ
X19mdW5jX18sIChpbnQpUFRSX0VSUih1bWVtKSk7DQo+IC0JCWVyciA9IFBUUl9FUlIodW1lbSk7
DQo+IC0JCWdvdG8gZXJyX291dDsNCj4gLQl9DQo+ICsJdW1lbSA9IGliX3VtZW1fZ2V0KCZyeGUt
PmliX2Rldiwgc3RhcnQsIGxlbmd0aCwgYWNjZXNzKTsNCj4gKwlpZiAoSVNfRVJSKHVtZW0pKQ0K
PiArCQlyZXR1cm4gUFRSX0VSUih1bWVtKTsNCj4gICANCj4gICAJbnVtX2J1ZiA9IGliX3VtZW1f
bnVtX3BhZ2VzKHVtZW0pOw0KPiAgIA0KPiBAQCAtMTM5LDkgKzEyOSw4IEBAIGludCByeGVfbXJf
aW5pdF91c2VyKHN0cnVjdCByeGVfcGQgKnBkLCB1NjQgc3RhcnQsIA0KPiB1NjQgbGVuZ3RoLCB1
NjQgaW92YSwNCj4gICANCj4gICAJZXJyID0gcnhlX21yX2FsbG9jKG1yLCBudW1fYnVmKTsNCj4g
ICAJaWYgKGVycikgew0KPiAtCQlwcl93YXJuKCIlczogVW5hYmxlIHRvIGFsbG9jYXRlIG1lbW9y
eSBmb3IgbWFwXG4iLA0KPiAtCQkJCV9fZnVuY19fKTsNCj4gLQkJZ290byBlcnJfcmVsZWFzZV91
bWVtOw0KPiArCQlpYl91bWVtX3JlbGVhc2UodW1lbSk7DQo+ICsJCXJldHVybiBlcnI7DQo+ICAg
CX0NCj4gICANCj4gICAJbXItPnBhZ2Vfc2hpZnQgPSBQQUdFX1NISUZUOw0KPiBAQCAtMTUyLDcg
KzE0MSw3IEBAIGludCByeGVfbXJfaW5pdF91c2VyKHN0cnVjdCByeGVfcGQgKnBkLCB1NjQgc3Rh
cnQsIHU2NCBsZW5ndGgsIHU2NCBpb3ZhLA0KPiAgIAlpZiAobGVuZ3RoID4gMCkgew0KPiAgIAkJ
YnVmID0gbWFwWzBdLT5idWY7DQo+ICAgDQo+IC0JCWZvcl9lYWNoX3NndGFibGVfcGFnZSAoJnVt
ZW0tPnNndF9hcHBlbmQuc2d0LCAmc2dfaXRlciwgMCkgew0KPiArCQlmb3JfZWFjaF9zZ3RhYmxl
X3BhZ2UoJnVtZW0tPnNndF9hcHBlbmQuc2d0LCAmc2dfaXRlciwgMCkgew0KPiAgIAkJCWlmIChu
dW1fYnVmID49IFJYRV9CVUZfUEVSX01BUCkgew0KPiAgIAkJCQltYXArKzsNCj4gICAJCQkJYnVm
ID0gbWFwWzBdLT5idWY7DQo+IEBAIC0xNjEsMjEgKzE1MCwyMiBAQCBpbnQgcnhlX21yX2luaXRf
dXNlcihzdHJ1Y3QgcnhlX3BkICpwZCwgdTY0IA0KPiBzdGFydCwgdTY0IGxlbmd0aCwgdTY0IGlv
dmEsDQo+ICAgDQo+ICAgCQkJdmFkZHIgPSBwYWdlX2FkZHJlc3Moc2dfcGFnZV9pdGVyX3BhZ2Uo
JnNnX2l0ZXIpKTsNCj4gICAJCQlpZiAoIXZhZGRyKSB7DQo+IC0JCQkJcHJfd2FybigiJXM6IFVu
YWJsZSB0byBnZXQgdmlydHVhbCBhZGRyZXNzXG4iLA0KPiAtCQkJCQkJX19mdW5jX18pOw0KPiAt
CQkJCWVyciA9IC1FTk9NRU07DQo+IC0JCQkJZ290byBlcnJfY2xlYW51cF9tYXA7DQo+ICsJCQkJ
aW50IGk7DQo+ICsNCj4gKwkJCQlmb3IgKGkgPSAwOyBpIDwgbXItPm51bV9tYXA7IGkrKykNCj4g
KwkJCQkJa2ZyZWUobXItPm1hcFtpXSk7DQo+ICsJCQkJa2ZyZWUobXItPm1hcCk7DQo+ICsJCQkJ
aWJfdW1lbV9yZWxlYXNlKHVtZW0pOw0KPiArCQkJCXJldHVybiAtRU5PTUVNOw0KPiAgIAkJCX0N
Cj4gICANCj4gICAJCQlidWYtPmFkZHIgPSAodWludHB0cl90KXZhZGRyOw0KPiAgIAkJCWJ1Zi0+
c2l6ZSA9IFBBR0VfU0laRTsNCj4gICAJCQludW1fYnVmKys7DQo+ICAgCQkJYnVmKys7DQo+IC0N
Cj4gICAJCX0NCj4gICAJfQ0KPiAgIA0KPiAtCW1yLT5pYm1yLnBkID0gJnBkLT5pYnBkOw0KPiAg
IAltci0+dW1lbSA9IHVtZW07DQo+ICAgCW1yLT5hY2Nlc3MgPSBhY2Nlc3M7DQo+ICAgCW1yLT5s
ZW5ndGggPSBsZW5ndGg7DQo+IEBAIC0xODYsMTggKzE3Niw5IEBAIGludCByeGVfbXJfaW5pdF91
c2VyKHN0cnVjdCByeGVfcGQgKnBkLCB1NjQgc3RhcnQsIHU2NCBsZW5ndGgsIHU2NCBpb3ZhLA0K
PiAgIAltci0+dHlwZSA9IElCX01SX1RZUEVfVVNFUjsNCj4gICANCj4gICAJcmV0dXJuIDA7DQo+
IC0NCj4gLWVycl9jbGVhbnVwX21hcDoNCj4gLQlmb3IgKGkgPSAwOyBpIDwgbXItPm51bV9tYXA7
IGkrKykNCj4gLQkJa2ZyZWUobXItPm1hcFtpXSk7DQo+IC0Ja2ZyZWUobXItPm1hcCk7DQo+IC1l
cnJfcmVsZWFzZV91bWVtOg0KPiAtCWliX3VtZW1fcmVsZWFzZSh1bWVtKTsNCj4gLWVycl9vdXQ6
DQoNCkNvdWxkIHlvdSBrZWVwIHRoaXMgZ290byBsYWJlbCwgaSBoYXZlIFdJUCBjb2RlIHdoaWNo
IG5lZWRzIHN1Y2ggZXJyb3IgcGF0aC4NCg0KVGhhbmtzDQpaaGlqaWFuDQo+IGJhc2UtY29tbWl0
OiA2YjgyMmQ0MDhiNThjM2M0ZjI2ZGFlOTMyNDVjNmI3ZDhiMzllMGY5DQo=
