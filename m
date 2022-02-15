Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C2E4B772A
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239971AbiBORTW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 12:19:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbiBORTV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 12:19:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED761AF33
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 09:19:11 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FH3vVG026647;
        Tue, 15 Feb 2022 17:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OkGVRn6tFgLq0PUiehTWEnA4iuK7rTOdj1fsIZ116v0=;
 b=bv0LyZjaFmWunRyHOlpRXfnmP6Bf2Bc9a9deHqOYblOFbVyuFugZg4Lgos2Pnuasi0+e
 sV3UU+YpACo5mObLApT7NUrUYB//dhbLaYUq3Crxyx//jSK5KuzqaqfAEi1+uV+lirVj
 0QaQI6beE4xRne2S52lrR464w30wW2MWjoEyn+vAaBtv6surVYBa3N7pW28kwSuBdY9+
 TSNrgIHMHxQa6ohXAOaBktY0XW0+uA5H4LBUF21T8dFos3FwrL9f98E/gbNvzZw5TC9e
 XyIsXJqXAR6s5eSNk840LhhgFtTiGu7PBGdZaaRvs6KQf1G5qypXDdHVF2vPma1aSef2 oQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e86n0j2fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 17:18:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FH65Aw061463;
        Tue, 15 Feb 2022 17:18:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by aserp3020.oracle.com with ESMTP id 3e6qkyj0da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 17:18:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFvpQKifdaky79lNG8IX3fLDshUQ4wKNKxKqqK5R9k36I1+Jmqzl6jJjOR82IdJkwcvelMH40R3rlEhaSAeV4M/wlRvvl2J2AySMO/F3avPd4A60ShQFuKKlcjs/CzEZ5ZiO35QmC77lzOmEycZNsf66EX4n51YlQUZ2DjcWmZJPm42J79OcRj76/6xF3BO7yuVjEVHGE3tkFCo8gVPeBwDB/iHORbtV2s2/JHnXED+AGcC93/5rEgXPPhYjcJL3oKining+A/vgMZxuiWddZVUJYY4nq19z08BomYEuarFK3AMVdiWUlrfuQFjEMVm+MWxDzvLKZIqxL1EBoeFPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkGVRn6tFgLq0PUiehTWEnA4iuK7rTOdj1fsIZ116v0=;
 b=EI+f6NmQPw1e6X6w6QX+yq9XV5vK4b9Wn6bHnX7PWknB4RKHXCplRHm/QyYT0ZmjxUfo1vZwFFy1/6jWC3o0qv0lm6cVqUuX+YZSXkB506LVw8QsAfSRycv3PvhJPPClVVAWmGGX4IbDSDcDyOOh2b3FHEZQp8t/snNYDEqUPoywU45qgAEuaPKKIiWOHffyGijCeWovo8SIcd9MmmVnfpqum54IDtW+ekAru0ZGj6hNjscM0mQ1udD3yZ5Gn4PgO0wyV1IpIADXtO2qtHdvbrCe1uq9qMzxTDORgGVumluSj4ce8h7iLoqntT1z+BlJWL74Zc4Ag5bMeM7z59hjyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkGVRn6tFgLq0PUiehTWEnA4iuK7rTOdj1fsIZ116v0=;
 b=FOtTpU0CZYGl5M785Nw1nyX8rAU3SpYQhu5Re9bJX1RpyEwCfXPT9V7HBS9rgwJNv16SBajP8vbYL9QKdFIL/oKb7kg1tsSm9CdOKSHva/7Zh1OnAl5vop3ZbGrSfz1kbwOYyExWEFoEnQTP3/HA0cVytjs9JNREQYCs1SKTbz8=
Received: from SJ0PR10MB5600.namprd10.prod.outlook.com (2603:10b6:a03:3dc::12)
 by CH0PR10MB5244.namprd10.prod.outlook.com (2603:10b6:610:d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 17:18:56 +0000
Received: from SJ0PR10MB5600.namprd10.prod.outlook.com
 ([fe80::5b6:33a0:d015:36a5]) by SJ0PR10MB5600.namprd10.prod.outlook.com
 ([fe80::5b6:33a0:d015:36a5%3]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 17:18:56 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Inconsistent lock state warning for rxe_poll_cq()
Thread-Topic: Inconsistent lock state warning for rxe_poll_cq()
Thread-Index: AQHYIczxb0wHyE0OV0m6MmKRJpkOeKyThZA+gACUzgCAAJZngIAAImCAgAAA4QCAAAF4gIAAAkwAgAAE0wA=
Date:   Tue, 15 Feb 2022 17:18:56 +0000
Message-ID: <4CD2BDCD-DFAC-427C-8A25-32A4F8C56228@oracle.com>
References: <8f9fe1da-c302-0c45-8df8-2905c630daad@acm.org>
 <a300f716-718d-9cfe-a95f-870660b92434@gmail.com>
 <89e17cc9-6c90-2132-95e4-4e9ce65a9b08@acm.org>
 <04a372ee-cb82-2cbe-b303-d958af5e47f5@gmail.com>
 <95f08f0e-da4e-13fb-a594-a6d046230d76@acm.org>
 <1f781fd6-a5e6-aa73-c43d-d16771fdef3c@gmail.com>
 <20220215144159.GQ4160@nvidia.com>
 <PH7PR84MB1488ADD314438A8EDEB5F219BC349@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
 <20220215164810.GW4160@nvidia.com>
 <PH7PR84MB14882185ED3BA2DEC460D894BC349@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
 <20220215170138.GX4160@nvidia.com>
In-Reply-To: <20220215170138.GX4160@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5164cb47-9f0a-467a-519c-08d9f0a73f87
x-ms-traffictypediagnostic: CH0PR10MB5244:EE_
x-microsoft-antispam-prvs: <CH0PR10MB52444B9B229EEB61DC7BBF69FD349@CH0PR10MB5244.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kq6dyWUJltIZT247jAn6n7TfBkTY57cybGBRfwnbxouGxzlFmD0Bu2KqMkXZ6zVyTPErEsNd9ZpAM1kPc2itVU3oacL9xtjLvPmL1MFEvqsOd1HiAkMiGT2COPey7YgvTLaEttffIDEimwkMdH3iD6QEROmQv2DEa6m98nfu+WutNe6BZmR0AKZ/qLojI6Tx1R6YiZ7arUQ2B+FcS4w4A9ZQNJFtere1/YQ9NlIX3YeeDH3cdVDAY7OaZjT6uBQUbD87eJGsHLtfFseOb5N6u0iyDPF2EPUzVuUi+54W99AAQ62sEykqkKOnyqPtARTg0a+iHE4KTFeuYlDyYMAQ8y8c9RkrgJl6iv3iRqUpnRQi2vEsSFRFM/AhUCF9LijAF9IAOSiUWbgmd6mt/nZzYIfgtI8ZvqhB6Uq03smNT3fciY/I+dS5qkvn1XR5ZMnowESofskV/YaLHSKZbk1A6R2IlTzVQVogYWUuu6baT83Db5I9ahpiRVcZulGvU57nFsRPJ7FBl1bwKlzO0MdsCTxT3IaZDOON2j8mPRV4Ll1McObanPZVp/DDThg7sfQSAw9XqgEfaEok1l10HGTIZw6mSqNJlfY8Rg2c/uII3ie46U4JIRyhDdHoAChsA9FL/n9xP89scofssAHfTazEaDuRnRWFiHs4KFPRG2bc4csZdnGcNxSgGSVURE85l0646um6V5/GXifDNHO65zGX6oppI4Uu2BT/spVlpDih3L07gxmtHCamhejYfTPwVmRHp4n+Yjz6BOaQNgC7wToitmqIuvq2wB3u7SOhreIMwxbiZ75SztoQ1tMKjhVcz6xcTfxL/x1X2O/SPRfLIAtN/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5600.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(91956017)(186003)(122000001)(71200400001)(2616005)(5660300002)(38070700005)(83380400001)(66574015)(6506007)(6512007)(44832011)(54906003)(38100700002)(53546011)(64756008)(4744005)(316002)(6916009)(966005)(66446008)(66476007)(76116006)(66556008)(4326008)(66946007)(33656002)(2906002)(36756003)(508600001)(86362001)(6486002)(8676002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFlFczJJd2dzdW1SNjJhaFdwMmNlbFAzNmlZLzltNVFkWEwvb29Eb0pDaVBu?=
 =?utf-8?B?UVY1YWpKVExsbEkxVnJONHFvS2xCWkZsT2N5M0M1OFMvbm5NVStuYnF2bnk0?=
 =?utf-8?B?bGFxU1Q5QitnSGtNc0JramV5RkVMU2NiUUFoQ0d2dWM0cjU2YXdpWnQxK0gr?=
 =?utf-8?B?cWFqM2ZhVnpCOXRtbUxrR01rOVhvNGp6bTRWb210VDJ0ZkNuZkpMUEdEckdS?=
 =?utf-8?B?VDlTdXlqOWM4UGNBNDlYK2o3dXVOd1hiRkhHT2lUMHhCaHFrUGJha080YUlN?=
 =?utf-8?B?czVEWTJJRVlVbUljMDdXTldMYVREN1Bub3ZtUEE2bUt6eEFwUTczTm5sdFhQ?=
 =?utf-8?B?RXJFYkN2bm1jc3hDY1RGclN4OUE4c3lSSlNBNWZMZ21QSWZ1OEJ5c3ArdTdM?=
 =?utf-8?B?MUhrVy81K0duYTg0OGp5V05VdXdCa1N3RFJtZ3dkaTd3Vmc0NW5ybVhET0dK?=
 =?utf-8?B?Y0I4QWZnT3lld0RYSis0b0VsOHdxK3NHemVnN0w0VVErWVhMRHBTc2FvWGNP?=
 =?utf-8?B?M0FlN1AzcGxoN3laaWJJaE9HbVUzQ2ZGc2ZFaWtVOXRKRTBBNU56Ui8wT25D?=
 =?utf-8?B?VStINWE5YW1yWXhIR0ZycXYrQkZPcDN6YkYwTldoSlpOSnVZWXhKeWZjVmN5?=
 =?utf-8?B?c0tOUlNIUzhINmVhY0l0SWlIWWtCam9lOWU4RWNRRnVVc0dLVzk5N201VlNo?=
 =?utf-8?B?bHVyY2xHWnFGME12MTFMUldqV2E3bEtKYklsK1ZrbFduRDlId094V3IxR1p6?=
 =?utf-8?B?YW9mYXJmS0ZMdlRYdkg1N0RsVWQ3d2RaSWwvOVJGZk5sRVZSSUJyQmFRUVpn?=
 =?utf-8?B?YjdYV3VXQVAzRWZyYVRuZDlIK2lZN1BWT1YrTnk1S0NHcnVPbFN5OUU4U3FY?=
 =?utf-8?B?YWRTWTdONHo4QzgrN3kvT1ZRWlJTVzBoOHRweFBEeHV5RjVWbHR4NitjTjd1?=
 =?utf-8?B?cWJTQ0xoQ0Z2VmN3SkV1MU5wVkVDQTMwK2NVMHRJU0lqODYvY0FPNUZsdzZ2?=
 =?utf-8?B?QjFmMVh0dnM4MkhLcENhT3VFTE12Q2l6WkpuWjdjZ1lwdUxta0lmN1BPQ3hW?=
 =?utf-8?B?S0gwakkxVHFlOGl3Tzc1NVB6ci9BNitLeHpCUitKYWorTEJ5eTVSdXZSUzNP?=
 =?utf-8?B?Ui92aVg3d00zSkZ3QUJUaTVtQjRPL0dSOXI0Y1gvcXVGVHZNN0F2ajY0STk4?=
 =?utf-8?B?eWwyeWF6dnJHOXU4ZHVLTFNvU1h1UE9td29sT0EzeVNObnNNSzdEUnk4cnkr?=
 =?utf-8?B?MVNaaVNtMEJhTk5zTG5teGdHQ0xUWnpRdTNnVUs2c3ZGQ2Q2c0hPRFlYQmFN?=
 =?utf-8?B?aGdwWTJCTEFieThrS0JzY1Nyd3BJNHlzUndoRU80VGwvWEk2U000eVZGZ1A5?=
 =?utf-8?B?eE5QKzNXY1JJZTNxSDFtZFU2Zlp5T3BBQWlLbEk0emJpTG9rWXR5T1JxSk1D?=
 =?utf-8?B?cTMxL0VVZzdQTDdmN09JelFvMWtzZGJjd09wbzZDYWxXQnV6N3FhcllyRldM?=
 =?utf-8?B?dVhSa0NIbW5URjREVWFwYTdvd0RqemxEamZKK2k3dDNDNEVyM05vcWlZNkhu?=
 =?utf-8?B?RUtOZXNRYjJUR1V4aXY5eElVSzVwMjhVN01xM01XaUw2RjRNYk5WVmR3ejkv?=
 =?utf-8?B?cDZKNityT05GTWRMczljTmtrVnRFMHc4UFI1ZnVyRVRDY0JiRmYvd2RZcUZ5?=
 =?utf-8?B?R1pRYk1xYUFqMXR4Tk4xUFBBaVhwN1FIS0o4UFdhOXJXaXNaNmFaVm45RlRI?=
 =?utf-8?B?L1dyRVFCSVRybGN3SGp5RHBhUnB4VjMxRWpkb1p2MVN6dlBiNUpKTHhuZ0R5?=
 =?utf-8?B?YkE2WEtmOWtKOGExMmVpS1hFK2VJb0NpeVpwSnA0TWM3NDJEamJDL0o4OEdu?=
 =?utf-8?B?T0NKWGpuUFNKcVFMbU5rYU1nb1BCZVpFempuMHhIQ1Q0dVIyVDJRZWZtYjFB?=
 =?utf-8?B?Ym5YYWtibHN0bDRrMGMyZm5xWEo5RXhBcWNIUXc5UTFBUE8vb3VaTlIzdC9q?=
 =?utf-8?B?YksvZHh5a1VTOUN1T1VWZG5ndk04czBVRnNoeG96UXpDaDd3c3cyQTRVdWZv?=
 =?utf-8?B?UjlmSDBBMjFiS04xa0IxdDNDU0FNaXJEY1NRbFJSNlhkUENGVWUzTWlEWFht?=
 =?utf-8?B?TXFlQzYrelcyVEtlbDRmUVJoYXBlMGgrcUcwN0V5cUxKaGxuQm83R3d0V2wx?=
 =?utf-8?Q?Kd86zNDpoRCWmrxPDGWZdn4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <334808A9C81E3D42BD5F22F2191BF7C4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5600.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5164cb47-9f0a-467a-519c-08d9f0a73f87
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 17:18:56.4736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPskMnZhPFrowRVWvlP98TJCuc7YtKnXs28q4pDChaX5UOfaANzMuXjJAgCEOszHKIRasc18NNM4ZBNd8PcBAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5244
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10259 signatures=675924
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=876 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150100
X-Proofpoint-ORIG-GUID: 8uJT8_VcuASqnT1vxUl5HFB3aPULmMBz
X-Proofpoint-GUID: 8uJT8_VcuASqnT1vxUl5HFB3aPULmMBz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTUgRmViIDIwMjIsIGF0IDE4OjAxLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgRmViIDE1LCAyMDIyIGF0IDA0OjUzOjI1UE0g
KzAwMDAsIFBlYXJzb24sIFJvYmVydCBCIHdyb3RlOg0KPj4+PiAgc3BpbmxvY2tfaXJxc2F2ZSgp
DQo+Pj4+ICB3cml0ZV9sb2NrX2JoKCkNCj4+Pj4gIHdyaXRlX3VubG9ja19iaCgpDQo+Pj4+ICBz
cGludW5sb2NrX2lycXJlc3RvcmUoKQ0KPj4+IA0KPj4+PiBXaGljaCBpcyBpbGxlZ2FsIGxvY2tp
bmcuDQo+Pj4gDQo+Pj4+IEphc29uDQo+Pj4gDQo+PiBKYXNvbiwgY2FuIHlvdSB0ZWxsIG1lIHdo
YXQgdGhlIHByb2JsZW0gaXMgd2l0aCB0aGlzLiBJJ20gbm90IGZpZ2h0aW5nIGl0IGp1c3Qgd2Fu
dCB0byBrbm93Lg0KPiANCj4gSSBkb24ndCBrbm93IHRoZSBleGFjdCByZWFzb24sIGp1ZGdpbmcg
ZnJvbSB0aGUgY29kZSBpdCBsb29rcyBsaWtlIHRoZQ0KPiBpbXBsZW1lbnRhdGlvbiBvZiB1bmxv
Y2tfYmggaXMgYWxsb3dlZCB0byBhc3N1bWUgaGFyZCBpcnFzIHdlcmUgbm90DQo+IGJsb2NrZWQg
YW5kIHVuYmxvY2sgdGhlbSAtIHByb2JhYmx5IHNvbWUgbWljcm8tb3B0aW1pemF0aW9uLg0KPiAN
Cj4gSSBkb24ndCB0aGluayB0aGVyZSBpcyBhIGRlYWRsb2NrIGlzc3VlIHdpdGggdGhlIGFib3Zl
IGJlY2F1c2UgaXJxc2F2ZQ0KPiBpcyBhIHN1cGVyc2V0IG9mIHRoZSBfYmggdmFyaWVudC4NCg0K
SSB3b3JrZWQgb24gYW4gaXNzdWUgaW4gcGVlcm5ldDJpZCgpLCB3aGljaCBjYWxsZWQgX3VubG9j
a19iaCgpIHdoaWxzdCBJUlFzIHdlcmUgb2ZmLiBTaW1wbHksIHlvdSBjYW5ub3QgdW5sb2NrIGEg
X2JoIGxvY2sgd2hpbGUgSVJRcyBhcmUgb2ZmLg0KDQpJIGRpZCBhY3R1YWxseSBmaW5kIGFyY2hh
aWMgYnVncyByZXBvcnRlZCBkdWUgdG8gdGhpcywgc2VlIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L25ldGRldi83RjA1ODAzNC04QTJCLTRDMTktQTM5RS0xMkIwREIxMTczMjhAb3JhY2xlLmNvbS8N
Cg0KDQpUaHhzLCBIw6Vrb24NCg0KDQo=
