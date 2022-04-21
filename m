Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8CC50A541
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Apr 2022 18:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiDUQ12 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Apr 2022 12:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiDUQNU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Apr 2022 12:13:20 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94501FCF0
        for <linux-rdma@vger.kernel.org>; Thu, 21 Apr 2022 09:10:28 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23L9W4C7027090;
        Thu, 21 Apr 2022 16:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=xLKU/iGzpkJ6e9gTPel4sVfMPPgryFs2nC3g1ouN7FU=;
 b=Os53FAM8U8XLdCfOJED3Ra4viUtsxKDLwcZE4glbL0B2MMxV/5UzO2crQaF9KiAhXtae
 BBeypUu6I+w+7fZ1KrWwbdSl70gfnE+0V6U7OKjtiOhDTBBp4+DSjPRF9Hn+/rFUASny
 gXQh8tlI0LYkix+dtHhUn9y7Tuh/1TdsFDXdic1Y4hg1J5amryC/QFSkpmpk0Lz/OvED
 dLqish/fSlff7XUB471ndaGL5KAWTXQOzGI7TS3665PBaZSqwIYquv9iAI4TrIQc8QnM
 9Oovl6NFKjvoGOaWBalXD8P6Rapo2eCw/0fHGhBfp2vIWgFS32Sch+1jUdRhchzWlTsu HA== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fjsu58m45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 16:10:25 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 6EF75800367;
        Thu, 21 Apr 2022 16:10:21 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 21 Apr 2022 04:10:00 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 21 Apr 2022 04:10:00 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 21 Apr 2022 04:10:00 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 21 Apr 2022 04:10:00 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isvRO6X+RiJFzYnAllZLCvOaf0NjdXxIUAUkSpMafFHAtlMWiOM512ud7ohYdq2sOh6wnzlRjYNnzxva4cM2Fn0/MTbmtKL58qaHpKuWvLxRkW9SYJaVV/mJ9UMfT0rn8cixC6L8pAH7YQdr87uiVhChUEQI0GgfHM3IFWC/4yWB2sPmF+wdZ/36Pgbp+lark/3tbkz3pW6XpmcpopUwutAK/ijeFhdm4+C24PvobWJwRn4Cn++m3DAeXvRusdLF2JaTtKBrZWnlHTyLa/vReCwQCXZ3gWbZkLcwKeijB1yrKLplvEw/mwyP82Vh+qz5ZvOTspyBfTmwbrJ1bzAXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLKU/iGzpkJ6e9gTPel4sVfMPPgryFs2nC3g1ouN7FU=;
 b=QqbcNCa9eg4sgKpHGJdS0Bc7RhhPaL5KF/+xlPP5Mp+qRLnUh5IlMwwLfFhvD2RCN4Mx0efUuNIYMhjxt4l6PqFlX8FEIPuZ04B87WbkBHe6Sj9u4xRfu8Rvy2tmQ6n1rbFy9GW4yr+N9CJhr+HLHnSIs4XvOgXHjb7BNcAIRdN4rom0tePzaX9vmzNp0QoWy5u6YE8sssbbf+xS6WxG/0UH/rI9PRLkj7x/DFzhJY62scHaL5UoFGJLr1N5FKm0/z1RiRFjD8VkZ0iSd1Lj7B+u7F7NJtyO0Sb23tOklgzxfokJGufLJxGmifujep+VIOGBZtEFXXft320gA6LgjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by MW5PR84MB1914.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 16:09:59 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1d3b:32cb:5dca:4e40]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1d3b:32cb:5dca:4e40%5]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 16:09:59 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v13 00/10] Fix race conditions in rxe_pool
Thread-Topic: [PATCH for-next v13 00/10] Fix race conditions in rxe_pool
Thread-Index: AQHYSHM7QFMOJ4t7TkC/A+40e7TIOqzmVfqAgBMvHQCAADTHAIAA6V3g
Date:   Thu, 21 Apr 2022 16:09:59 +0000
Message-ID: <MW4PR84MB23071182721552AE6216D77ABCF49@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220404215059.39819-1-rpearsonhpe@gmail.com>
 <20220408180659.GA3646477@nvidia.com>
 <fe069eac-889a-460f-ffb6-fc4e46ff3267@gmail.com>
 <CAD=hENfKUe5Q8yg4P7ms+FxyU1+cAPMJWPXL_Ps=u+JMznmT7w@mail.gmail.com>
In-Reply-To: <CAD=hENfKUe5Q8yg4P7ms+FxyU1+cAPMJWPXL_Ps=u+JMznmT7w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a751a76a-ba70-46f6-e40a-08da23b16241
x-ms-traffictypediagnostic: MW5PR84MB1914:EE_
x-microsoft-antispam-prvs: <MW5PR84MB1914995BAAC330F25E0463DCBCF49@MW5PR84MB1914.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CiAsYSSO4NGXWh/98vSjAaVqlesf7fe3SBZWZY4b5H1KnnM4kpauDdiiZYY6E6XhmABvrX44cZi7mikufDwRDn6EL06VOIANpu7e4cSFdZsbSHorUpyPjGTzgfSScun0TMBf7s43nFZTO3hXS6mHjfgPoUcp/wQl7DpyphgBZ+OnOBPvPCR6hbxIkaVYlNQ5W26PXTEOwD2AZJvZXTlRYTRdMsa8KbnUZGBTMNluGfucig58GJmoesLjyp1GvdDe6HQyntFj+NBPqPWO3Z1U4t6EDUW3vyu2HQeJ387HhQqqRJX2joHyUrGZ0kzkryQgEDOZakxtrBRLARxD+lmhyuuTYVepkhG74K1QZbispW7LDSiWFmPNwdb/Y9f7n5DbQfr6bWPSIH3ywHLcYY0oze+rU9Mm8akE35XLfd37eqkBuoEqxsLqCGzqi5h51UAA37YFgUcV8kCc2poeEU/29Kmhzy9n/SeL2ZaGIYY+mpxXemiAX8VRkOFupfjWFpwwrJlH9rsbH+hsJArFT1lZXQQCGAR38Tm2/8QSYzfIzaXjFVEkjTkLBFB/mTy8cqoU+KE6nnshFAyXkp66/pt2DeMrblsv67UuImFdoeOjFvnfU2ryLfdPefe7EL2DWeEsaOj6017qu63JbOm2RY1CbIDFIcYJmHTseAVO4NInz0dKH42ca0yaokogpgwvyS5Gm9kSBYUOdDZK7F9Otg/NgTuBJn16HnG3vrQ7J1VkFuk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(64756008)(186003)(76116006)(86362001)(66946007)(55236004)(9686003)(26005)(66476007)(53546011)(7696005)(66556008)(6506007)(52536014)(8936002)(55016003)(82960400001)(33656002)(66446008)(2906002)(5660300002)(8676002)(508600001)(83380400001)(4326008)(110136005)(316002)(38100700002)(54906003)(122000001)(38070700005)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFpmK251cWlpbVBYb1FDaFVTMG1raExsZUNST0Z0eXBMWGRNRng2UHBZeG5s?=
 =?utf-8?B?MkFNZGRBZUVXamlzMXk1TExXTXBLMzVabGdHRDlBVko3TEZrTEZpQmcvY1hT?=
 =?utf-8?B?eTkrS08rTUV6anMxQTRHRmFHcGZTZ2IyczZSYmovcm0rTlFMMElIa1FWNEpG?=
 =?utf-8?B?U2VnOTJLMEdpaFMwc0tOaU9CUmtRS0paZUNxSXp3UVhUbWRSRFF5OXV4czJr?=
 =?utf-8?B?bG1NMnFmWXVzSFZseExwM3FiTWg5VXJaYjgvR05BR0hWWHRWZkpzelY2anBw?=
 =?utf-8?B?V0Z3d1NLd1B4cVVxOHdhZDNXczhrT2FtOXBXLzRUMXFZWGl1TkdsdTJIakZM?=
 =?utf-8?B?VHZDY0lhMFJham5RY0NVOFVXemtMQ2lRODg4ZlZJNC9KUnZDNDJ6MjhyTFJ4?=
 =?utf-8?B?d1labzVGOE9uaW9Nck5nUGZOR0VsTGFoT0dtOHJ5ZURobHhEUGRQdlNkT01S?=
 =?utf-8?B?NTRTRFhHdmpERnZRNXJEMVI0bFFONWZVYVE4Y0ZIN2lxY2dtb25ObnluZHdu?=
 =?utf-8?B?bVB1SjdtYjljVVhnOEI0MENjTm1Wd2JyYURYMnhqN2lLTHpWbU1nM2dmQlBx?=
 =?utf-8?B?OThSK1dMTzVoTkdnemdEOSt3MTYxR3pZd1g5THFZNFZhKzJ5VEJ3UTcyZ2Jj?=
 =?utf-8?B?bURGcGxHdE9IMDJWNU1JazYxOE5SVkVuWEQzbGdnbVJZUnkvdWdiVXoweTdI?=
 =?utf-8?B?dW10NWx1d3RXdlJBSWp0ejZHMVg2VkxRZG96VVdIWTZCMnJFUVFyeTVISy9m?=
 =?utf-8?B?WGF4cHEybldiWG5ZMHZjQXlLLzlOUTZhbjFzODVkWnRoMXNYMVEyQUduWE5Q?=
 =?utf-8?B?Z3pHWEFBTnY1V3RhdVM3aWJWa25UZzAyd09oNnFyb3JaQSszelN1c0s2NHpP?=
 =?utf-8?B?MnFySkx6S1pLeG80L29iZGFmRDJ6WllxUkVmdC84ZWk1T0plT1VvQ2JQUVR3?=
 =?utf-8?B?bFpPajJPN0JxeXk1WXR0ODhZTkpUdGdMRDZmc0xTTWlIaDE1Y2VINmQyc2sx?=
 =?utf-8?B?eUdPbmF3UWs3YmNONmtrQWpzbk9qOGcycjJCNENSa3llaFF2T2lXUkpuWUkw?=
 =?utf-8?B?aEp6REdTQnZ2bFh0djdtR1BpaXY3UnY5RkozYUUzVVR5bWFpQ0RaWHRrTC80?=
 =?utf-8?B?WmNGVWt6VSt2MHZPbVJEOStTNUwxTVpkcUROWTVJaXJhWjBacmdkNjFVUFVk?=
 =?utf-8?B?S1BrK05Xc0RSNEdlazlRN3pXZ3U1ZVNBVUFadXJFd09KNCthT2VXd011aWFH?=
 =?utf-8?B?ZXQ5a2xIMUwvdUNicU05R0pZZEVLelBod3BXL1cvcmdkSUw2dzNpN05aTnhW?=
 =?utf-8?B?T20yQVFldThsVDhiZW5GZzUraWVKdlhVbnpIWDRkNUJqYmNHcm9Yb2tmVEZY?=
 =?utf-8?B?L1ZxamtobXVaRVVRRENBY2Z3UU5VQThvRWhSL2E2U0dBOVZYc0JZc2NZVXBT?=
 =?utf-8?B?dWlHekU1U09qTE9IUStzekpTd0NvRmEzdWR6eXVoNmZiK3daNlZ3RW1EWmc0?=
 =?utf-8?B?TVdtRThYUncvSlA5N2QyNnJaTVBQbWRsRFhQRWFTeWdUcHdrVVRtMWU4d05P?=
 =?utf-8?B?bXpldXIvMndxRTZJMWRBSGNyczVHZFVmdWppWTNWeUVsMnRqOVRsYVg3aE85?=
 =?utf-8?B?bG5nd2RvZVczOXhtQVpVRmZMbzBSRDBZVDJiR1UwQ1RuNVZUOCt1Rm9oendJ?=
 =?utf-8?B?SlhBbzdzSzNCVUhjQ2x5eStBZEU4TWppYk5JTkNhREhvY29xdnZMVHU2ZmlX?=
 =?utf-8?B?NjBBUFhuWFJBR0RQMFFIT0d2YkQxZmYxTks5a2VHeWZmWVE4UjBXMnJwTVQv?=
 =?utf-8?B?Z0VoZmhvdHBocUVvMnlZZ1ludUZiZ01GNHhzU1UvWDRadHdlcS85T21DeWN1?=
 =?utf-8?B?cVYzWHhMcHhJQ1Nzc1haMDE1UFI2ald4V3VCWDd2ZGtlMmc1WWx4dEY1OUl5?=
 =?utf-8?B?aXBFam9wMEJYdTdaNEtodlVEdk84VlNFN2xvZy9LUStKM0FEVVB2TDE1ZjZm?=
 =?utf-8?B?VHJqeWRsNVEvYUxVSXdSV0hWTG5aak52dkxzemZsakJZOS9wYURLV09DbU42?=
 =?utf-8?B?TmpwSjFyWnhQVjZFenpzamY0cWtURHhnVC9uVDkyYzU4ZVVwS2RhdTBYRkdG?=
 =?utf-8?B?MXZWNjNwb1VaODRKUGJQdlRNWmt4cnRQUDJOa1pIcE1WbjZjTVU5QURwZS8x?=
 =?utf-8?B?RW56ZFEvNE5QTndYb3JpT2p2VlhPcHpic3hDc1Zxb2dVV3V5SDA5T1N2c3Fz?=
 =?utf-8?B?NXFPZTZ6cUl3K05KR29aTXk3cDRUMFZMdWp6cWRKWFZaQkRhUnhyUXRxS3B2?=
 =?utf-8?B?QlpJZHhVYm5PYXY2dXcrODRPd0pMNzY1bXc1OEFWSzdtVFcvbHhGdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a751a76a-ba70-46f6-e40a-08da23b16241
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 16:09:59.0233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kKpexuv7LN90zeEHx9Ng961rA6M6cU4T1+Uz5TbQVfIrFJn9T8nfRAQvXo9K9vrArUKQTgwoiyKTi8xXGhecYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1914
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: vkTcaEjn8puKZPYd1iwCXfrHfpC51Jd5
X-Proofpoint-GUID: vkTcaEjn8puKZPYd1iwCXfrHfpC51Jd5
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-21_02,2022-04-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 mlxlogscore=726 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204210086
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Wmh1LA0KDQpTb3JyeS4gSSBhbSBub3QgdHJ5aW5nIHRvIGltcGx5IHlvdSBhcmUgYWdhaW5zdCB0
aGlzLiBKdXN0IHRoYXQgeW91IGFyZSBtb3JlIGF3YXJlIG9mIHRoZQ0KY3VycmVudCBvdXRzdGFu
ZGluZyBidWdzIHJlcG9ydGVkLg0KDQpCb2INCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IFpodSBZYW5qdW4gPHp5anp5ajIwMDBAZ21haWwuY29tPiANClNlbnQ6IFdlZG5lc2Rh
eSwgQXByaWwgMjAsIDIwMjIgOToxMyBQTQ0KVG86IEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBn
bWFpbC5jb20+DQpDYzogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IFJETUEgbWFp
bGluZyBsaXN0IDxsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZz4NClN1YmplY3Q6IFJlOiBbUEFU
Q0ggZm9yLW5leHQgdjEzIDAwLzEwXSBGaXggcmFjZSBjb25kaXRpb25zIGluIHJ4ZV9wb29sDQoN
Ck9uIFRodSwgQXByIDIxLCAyMDIyIGF0IDc6MDQgQU0gQm9iIFBlYXJzb24gPHJwZWFyc29uaHBl
QGdtYWlsLmNvbT4gd3JvdGU6DQo+DQo+IE9uIDQvOC8yMiAxMzowNiwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOg0KPiA+IE9uIE1vbiwgQXByIDA0LCAyMDIyIGF0IDA0OjUwOjUwUE0gLTA1MDAsIEJv
YiBQZWFyc29uIHdyb3RlOg0KPiA+PiBUaGVyZSBhcmUgc2V2ZXJhbCByYWNlIGNvbmRpdGlvbnMg
ZGlzY292ZXJlZCBpbiB0aGUgY3VycmVudCANCj4gPj4gcmRtYV9yeGUgZHJpdmVyLiAgVGhleSBt
b3N0bHkgcmVsYXRlIHRvIHJhY2VzIGJldHdlZW4gbm9ybWFsIA0KPiA+PiBvcGVyYXRpb25zIGFu
ZCBkZXN0cm95aW5nIG9iamVjdHMuICBUaGlzIHBhdGNoIHNlcmllcw0KPiA+PiAgLSBNYWtlcyBz
ZXZlcmFsIG1pbm9yIGNsZWFudXBzIGluIHJ4ZV9wb29sLltjaF0NCj4gPj4gIC0gQWRkcyB3YWl0
IGZvciBjb21wbGV0aW9ucyB0byB0aGUgcGF0aHMgaW4gdmVyYnMgQVBJcyB3aGljaCBkZXN0cm95
DQo+ID4+ICAgIG9iamVjdHMuDQo+ID4+ICAtIENoYW5nZXMgcmVhZCBzaWRlIGxvY2tpbmcgdG8g
cmN1Lg0KPiA+PiAgLSBNb3ZlcyBvYmplY3QgY2xlYW51cCBjb2RlIHRvIGFmdGVyIHJlZiBjb3Vu
dCBpcyB6ZXJvDQo+ID4NCj4gPiBUaGlzIGFsbCBzZWVtcyBmaW5lIHRvIG1lIG5vdywgZXhjZXB0
IGZvciB0aGUgcXVlc3Rpb24gYWJvdXQgdGhlIA0KPiA+IHRhc2tsZXRzDQo+ID4NCj4gPiBUaGFu
a3MsDQo+ID4gSmFzb24NCj4NCj4gVGhlcmUgaGFzIGJlZW4gYSBsb25nIGRlbGF5IGJlY2F1c2Ug
b2YgdGhlIG1yID0gTlVMTCBidWcgYW5kIHRoZSANCj4gbG9ja2luZyBwcm9ibGVtcy4gV2l0aCB0
aGUgZm9sbG93aW5nIHBhdGNoZXMgYXBwbGllZCAobGFzdCB0byBmaXJzdCkgSSANCj4gZG8gbm90
IHNlZSBhbnkgbG9ja2RlcCB3YXJuaW5ncywgc2VnIGZhdWx0cyBvciBhbnl0aGluZyBlbHNlIGlu
IGRtZXNnIA0KPiBmb3IgbG9uZyBydW5zIG9mDQo+DQo+ICAgICAgICAgcHl2ZXJicw0KPiAgICAg
ICAgIHBlcmZ0ZXN0cyAoaWJfeHh4X2J3LCBpYl94eHhfbGF0KQ0KPiAgICAgICAgIHJwaW5nIChu
b2RlIHRvIG5vZGUpDQo+ICAgICAgICAgYmxrdGVzdHMgKHNycCkNCj4NCj4gVGhlc2UgcGF0Y2hl
cyB3ZXJlIGluIHYxMyBvZiB0aGUgIkZpeCByYWNlIGNvbmRpdGlvbnMiIHBhdGNoLiBJIHdpbGwg
c2VuZCB2MTQgdG9kYXkuDQo+IDhkMzQyY2I4ZDdjZSBSRE1BL3J4ZTogQ2xlYW51cCByeGVfcG9v
bC5jDQo+DQo+IDZlNGM1MmUwNGJjOSBSRE1BL3J4ZTogQ29udmVydCByZWFkIHNpZGUgbG9ja2lu
ZyB0byByY3UNCj4NCj4gZTNlNDZkODY0Yjk4IFJETUEvcnhlOiBTdG9wIGxvb2t1cCBvZiBwYXJ0
aWFsbHkgYnVpbHQgb2JqZWN0cw0KPg0KPiBlMWZiNmI3MjI1ZDAgUkRNQS9yeGU6IEVuZm9yY2Ug
SUJBIEMxMS0xNw0KPg0KPiAyNjA3ZDA0MjM3NmYgUkRNQS9yeGU6IE1vdmUgbXcgY2xlYW51cCBj
b2RlIHRvIHJ4ZV9td19jbGVhbnVwKCkNCj4NCj4gY2EwODI5MTNiOTE1IFJETUEvcnhlOiBNb3Zl
IG1yIGNsZWFudXAgY29kZSB0byByeGVfbXJfY2xlYW51cCgpDQo+DQo+IDM5NGYyNGViYzgxYiBS
RE1BL3J4ZTogTW92ZSBxcCBjbGVhbnVwIGNvZGUgdG8gcnhlX3FwX2RvX2NsZWFudXAoKQ0KPg0K
Pg0KPiAzZmI0NDViNjZlNWMgUkRNQS9yeGU6IEFkZCByeGVfc3JxX2NsZWFudXAoKQ0KPg0KPiA0
NzMwYjBlZDc1MWEgUkRNQS9yeGU6IFJlbW92ZSBJQl9TUlFfSU5JVF9NQVNLDQo+DQo+DQo+IFRo
ZXNlIHBhdGNoZXMgYXJlIGFscmVhZHkgc3VibWl0dGVkDQo+IGQwMmU3YTcyNjZjZiBSRE1BL3J4
ZTogRml4ICJSRE1BL3J4ZTogQ2xlYW51cCByeGVfbWNhc3QuYyINCj4NCj4gNTY5YWJhMjhmNjdj
IFJETUEvcnhlOiBGaXggIlJlcGxhY2UgbXIgYnkgcmtleSBpbiByZXNwb25kZXIgcmVzb3VyY2Vz
KDIpIg0KPiAgb3Igd2hhdGV2ZXIgeW91IGNhbGxlZCBpdC4NCj4gNWU3NGE1ZWNmYjUzIFJETUEv
cnhlOiBGaXggIlJlcGxhY2UgbXIgYnkgcmtleSBpbiByZXNwb25kZXIgcmVzb3VyY2VzIg0KPg0K
PiAwMDc0OTM3NDQ4NjUgUkRNQS9yeGU6IEZpeCB0eXBvOiByZXBsYWNlIHBheWxlbiBieSBwYXls
b2FkDQo+DQo+DQo+IFRoaXMgcGF0Y2ggd2FzIHN1Ym1pdHRlZCB0byBzY3NpIGJ5IEJhcnQgYW5k
IGFkZHJlc3NlZCBsb25nIHRpbWVvdXRzIA0KPiB0aGF0IHdlcmUgbm90IHJ4ZSByZWxhdGVkIChz
YW1lIGlzc3VlIGFsc28gaGFwcGVucyB3aXRoIHNpdykNCj4gY2RkODQ0YTFiYTQ1IFJldmVydCAi
c2NzaTogc2NzaV9kZWJ1ZzogQWRkcmVzcyByYWNlcyBmb2xsb3dpbmcgbW9kdWxlIGxvYWQiDQo+
DQo+IElmIFpodSBpcyBub3QgT0sgd2l0aCB0aGlzIGxldCBrbm93IHdoYXQgYnVncyByZW1haW4g
dGhhdCBuZWVkIGZpeGluZy4NCg0KSG93IGRvIHlvdSBnZXQgdGhpcyBjb25jbHVzaW9uIHRoYXQg
SSBhbSBub3QgT0sgd2l0aCB0aGlzPw0KDQpaaHUgWWFuanVuDQoNCj4NCj4gQm9iDQo=
