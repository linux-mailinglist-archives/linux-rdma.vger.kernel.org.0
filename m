Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1354EC4EC
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Mar 2022 14:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344806AbiC3Mvk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Mar 2022 08:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244177AbiC3Mvk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Mar 2022 08:51:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2105.outbound.protection.outlook.com [40.107.220.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2408016F076
        for <linux-rdma@vger.kernel.org>; Wed, 30 Mar 2022 05:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Smr1uYPQAnYOFDCUhKUymfz1wqgvTetcAGb4yplMB8rSA/g5cmnqIovCnnL9i0AfSBdhYU6TvpIPLmKpb/PTnA8Xaqoy7syWqowax2OoEPc7xlemSe8+IgBv83Pp6c3UBs8q6IGEBKkkFCCLNgMqOVIiaMYB5MlIlDd+vNHeypDmg40NawH0e2SGX0DpSHK/eUgay6dIXu/X/djKSSOBbA1M9gmw/ohFjhPqBk25x4kUsx0QJ7qXTxMF2pNwsz759D8Yx2ZU5QZZoAf8Fuj5F/uS5PKvVwslOqdk43Q5y3iagJpyOA7qJ0Gquj8d6G0BzUWnIBudrbvfxkQhtKuw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqQYqW4VzVFw3DOfR50mvl9oJYzdqcrkCt2XooLIBMY=;
 b=VQl4WcGDSepOFBMrEOD+W6pvqb9Pfj9oM3OJ9yYCvCTPzRekAK1+MKSdERW/m23+ZNeAp9SBkL8/YstLNytr6y7rsG+Ln5l+MZEV6md4WvIQRlKqDcLgoooTbZ6+eRXo9BNCf2HLanglNnjjvb/Ws/srIzbEr+udX6jmZzsOy5eh4MeFn52Z7p1/CVMUPen5Dz4t/P/P1H20OBEr6/bQ3WMxmYqYOOzdT9KlkyuMFBx2mn3s5wkH9oWTxELz0CC0W61/GEEGo1G14DRoZ5uW2dfLevW2FCAHNXA+RLKdxCwcR05z4ONlTNQgLh2YDxQc1pIylolUzItNX+V0J274aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqQYqW4VzVFw3DOfR50mvl9oJYzdqcrkCt2XooLIBMY=;
 b=AzV7pqqOfovjE9H9C8/Qtn5HgpHRNmPhXxhGc7iPN3P7pgyIOoEsjO85R9k9Ore3x2h4WqNJh67QPw6Yyr90T6bCsXpfMRCICWnPr32McgSAdzgJNE4UNRA0QGnA8qL8KZEm6pn5Rin8Ed/ZDP/sPexL4M6jrS/VFLG6liRGQsukAxyMuEzayu5KLOvli6LVtThwGXXP1Cq/qzh8Q6xiBbv8zqNiiCNRXGUjsy5cCBSCXA79/ECODQjK5IjCp7EqQpQv/e5Bhzz005vFUvSUVcU1kZBCb+5gGVQOj8xJ5tHXJ75WUCpmeXprdeLBpog06TPVdYZ1xL630k+VtEiM/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6446.prod.exchangelabs.com (2603:10b6:a03:29e::12) by
 DM8PR01MB6999.prod.exchangelabs.com (2603:10b6:8:18::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.16; Wed, 30 Mar 2022 12:49:53 +0000
Received: from SJ0PR01MB6446.prod.exchangelabs.com
 ([fe80::5472:5f30:5a0c:d143]) by SJ0PR01MB6446.prod.exchangelabs.com
 ([fe80::5472:5f30:5a0c:d143%7]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 12:49:52 +0000
Message-ID: <8534b2ec-0b12-88be-891e-eaeef0ab7cf9@cornelisnetworks.com>
Date:   Wed, 30 Mar 2022 08:49:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH for-next] MAINTAINERS: Update qib and hfi1 related drivers
Content-Language: en-US
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org
References: <20220329184221.182061.69846.stgit@awfm-01.cornelisnetworks.com>
 <YkQKrn2T+NNCt9xX@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <YkQKrn2T+NNCt9xX@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0240.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::35) To SJ0PR01MB6446.prod.exchangelabs.com
 (2603:10b6:a03:29e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c4bb02e-268a-460f-7076-08da124bc6d2
X-MS-TrafficTypeDiagnostic: DM8PR01MB6999:EE_
X-Microsoft-Antispam-PRVS: <DM8PR01MB69994AF65AF2B3E772A845A7F41F9@DM8PR01MB6999.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m07s9NGFzc+LkPdUpHwFGWdBhsNNXykwrAWmiCzS18vlLnXyHlSuH7wDObRWAZ/E1czY0om2Ja+VGPesFMEB/Asr76CG2eeZ1l7UlgO7M0Socajmm8LjMrpx0I63wXBdUVTIG9MHWHfHycNwLBWJ/OZNc1rRkQDBpcwIEx5ANb8NMgkZwm5ayTmLZsTK8oyXztDW5RUHqV6+9QerJ/0pVVg71JqFz9ztJAcXSbjstuAirjCC+c43vDTOsL7rB4AWY5mVpIr+H9ud36mVkMuuhCKkTrpe8DG1ENAcjwVy3dratZyKff9wt5dHtpspxRBQOf4l+SwsZZ+wfCxJM/Kxu5S9aOGvrBMJhBlUIU4hap8+vim1OA4+ypHEPHmQkeOYHjACUwl4V2R0toTP4j4YAlNlcQfpHykZ9IoaCNSPPIqEyz6UfH9RhHk9tuu9h3+8dUHBDdjWCdBLISIjulzg+LqT0UHesgv7PdcJ34iVfRJqhpGXw/VnP0AtKdILnrHtE5g+QAnpjAnKOQLVZBKL/r1cyv4xGuHDAXYNShwVEv6AmG0I45plD0eWofeo3yXUReMbiOCp7Euvtwbx8y+OS6qQ9km+4qgZegE+zzUZy9VHNXtvpDSQ+7nRi8TEP0j1pQld4TJdUirltmEx8bnGWdT5c0753UOeUKvh9e/40Jt7grAyuuA56kKpJ1b4xlr+lnY/x42Adrwjmr8Ji2wdLxPrkphiaUX8uZBv0J5DgdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6446.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(376002)(39840400004)(396003)(346002)(136003)(366004)(5660300002)(66556008)(38350700002)(38100700002)(66476007)(86362001)(8676002)(4326008)(31696002)(186003)(6486002)(66946007)(2616005)(508600001)(8936002)(6666004)(26005)(31686004)(316002)(53546011)(6512007)(6916009)(83380400001)(2906002)(36756003)(52116002)(4744005)(44832011)(6506007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWg4WWVVRURnSmFTYVJ3MlpRbXJYdlRKd2haNGN4UExLZ3lqNW1NS043TEw1?=
 =?utf-8?B?K3V5NnN6UFZLZXNnSE16Q0FJRXhtc09lbDJTUHMzeEg1UUtRQWtZaHR6b2o1?=
 =?utf-8?B?ZVlFTkdwMmt3RlV2bTcvZmNFRnhQdlowS1RlY3poS013S3pQYTE0dy9WdTZ1?=
 =?utf-8?B?WDFFNmk2QUZOOS9LK0JheGlxMy9RSUxzNjZDMG9qWmJJZi90N282ei9WTlJR?=
 =?utf-8?B?UUJKdEpHODV1VjMzdU45Z0p3V2pWU3RsK2JWVWxFS2pJL1lwVTRxdE5Cb3JV?=
 =?utf-8?B?ZFlUbWc2M0R4UjhJWE5CVjlTREg0N0NNMkh0UERhTU9Ia2hKbG9mc2JxRmFi?=
 =?utf-8?B?QlRZZC9zSHpWbmt2MDEwZVVRSE91MEFWZm1Oa21ITXlQRWxxRE4xTjRnaUtL?=
 =?utf-8?B?bEdmYk1ESkozeEJkTDNkanhvYlovZXVMYURLclUySldTSzlESVg2VUk5NnJj?=
 =?utf-8?B?RllQRzlaWkZ6b2ZGb2MrMnN4ZjZwcmRUZW1LdFFKOEM1YnhxZmtaUy9wa1pz?=
 =?utf-8?B?SlQxRXcxVWRQTytYdFNlU2doVVkvck9GbEg5bkhqSEVadldXczR2WC9QUFpQ?=
 =?utf-8?B?QTZ3N0pRQ1VWWmNoYUVhSHlXTTlDRmNVK1NGcVVtR2ZFYnJpWCs4MVAwRWk2?=
 =?utf-8?B?RERCN1lCNUFqS0hLK01kelFxT0UxWkxkbVpWTFQwSkFuYUx5Y1dGNmM5aGs3?=
 =?utf-8?B?SFF6TnE1Z0tLZSswUU5mdHIxTmpPZWpVQ2h4ZVhxMEtXeUM1R2l0MGFsQjg3?=
 =?utf-8?B?OURMR1Y0ckQyN25ocmgwSGx3QlpxekI3TGk2ak5FaWExL05Hblpha0h1S2ta?=
 =?utf-8?B?RndKSFUxaTVQbStlZE9RTVBCVUErY2hkVHY5MHpPbHFXaDlXUFVrZkx4TXAv?=
 =?utf-8?B?WXR1emNYVGdSd0VUekQ5ZEpaaXN0OEExTU5tWE9jeGRBeFlXeDB1WTBabnJK?=
 =?utf-8?B?V2NnTWsvbmI3ZDZtaWV2NDZpMEtJeXp1akNaVWlKdVFOUUpKVzJMTjZDN3du?=
 =?utf-8?B?dzNJVS9RTGdCcjc0bU1oZnJVdEVyallSSlJMY0pRUmx3TVFFQ3pLTkg0cVF3?=
 =?utf-8?B?NXNOTFFtaCtWQy85NkJpclp6VENWbk5yZ1dlaWllMGtiMkIwcG40M2NjZTRu?=
 =?utf-8?B?d1JzY0lQQ25QN1M0ZE5kK1dvUDE1NjFieFE0d0dSWUxnODBOV0h3L1I2eEE4?=
 =?utf-8?B?MDcwOXJZTWhNdjdOanIveUxxVFI0SWNpdGZ5Vld1RE1JdjhOTzF3QStieW1a?=
 =?utf-8?B?SjdoQ1ZCK2J5ZFVzTlFHNytSMDB6c2hqUEVJemtNd3pLMnBSZWFZSzNRakZr?=
 =?utf-8?B?N3ZHbGpsaGtEak5WWnY4RTN1bVhNNkdwV1IxZUR2UG1DaEcvM0R2SExOSGQ5?=
 =?utf-8?B?OHc2N3JUcG1WL3dpdVJrR3FLb29HM1o0V0g0MDVuaVB2QlFIN0tLNENQQjAv?=
 =?utf-8?B?WTFnUHN5WjRJT1NKWWZHOFp2OFJWK0hzV1NjQ0h2UkJ0YjAwUldmSS93MUhG?=
 =?utf-8?B?Tm81UmJ6bkZkN3FMcWpEcDNUNTVYeDVaWEdrUkVuRmttQlV6NDFMalBWSVJ2?=
 =?utf-8?B?MkFZTEo5SjY4eldxUFBtbllnVHJJZXp3RGJXZlF2WlhSeTFSaU93ajB6bnZz?=
 =?utf-8?B?T0FhUjd1KzFCY1EwYU8yNG1nYmFmSGFUckRhSkx2T0NwUWhNSnBtLythZVJJ?=
 =?utf-8?B?c1RwOVNXMk5IQnlqN1hDS1ZiK2J4ZnNza1Y1Rk10eDAzNHhocWRCZllyc0RJ?=
 =?utf-8?B?K0lPdlBXRCtPU1oyMHZrS1BtS0c3dk1OTlN3R0pGbGxaaDB3UUYzZFY5Z2dE?=
 =?utf-8?B?VFBRbDh2RUVMRElQNnh4TDNSeHJvV2JaTzRCR3JEdGNuMnlGUUtlZkZFdncw?=
 =?utf-8?B?S281ckZnTGgyc0F6Q0tqWUlLcXZiS3MwbFgrN3VxYmdMclAwRldZZnJ5VmQ2?=
 =?utf-8?B?YXZwZHpYQTVsN2l2R21kdXJEWWZGTm1Bd3E3VUZkdnBHbnZPY1ZsSFZ1NnpH?=
 =?utf-8?B?d2huclRDN1lJMVF5c2tnMVFVS2dsanBxYVFMUHNyek1qTTV5ZTFwWkFkMjdM?=
 =?utf-8?B?VTk5ZzZtcUZjTU8xYVRSWnpRdUtDZWttSGQ0bCs0ai92MlBLMzF6ejdNdjhw?=
 =?utf-8?B?NU9LbXlRRmcxdXFMeGlvY0JJM2xycngrRDNIYTJQcU1pTXl5dXFOSFJKWm5i?=
 =?utf-8?B?TEJkaG93L09pMDl3Ti8zWG12N0lPQU4xNTZORFdNdFc1OFFHa2xSYUFhYjY5?=
 =?utf-8?B?RTcrdUliNWEvRVBSd2piOUJaM3BLUUs3RkJ0RGJvcmNKZkIxSm1TOG00WjVP?=
 =?utf-8?B?RWs3VmFZM1F2UGd4YWIvbzk1Q1Jydkp4WEk4akpOTFY4YmNRc2MyTVphcXlQ?=
 =?utf-8?Q?Vg5v0AvQjiUOcaj4mWojjq30PFbLu3v3UyOri?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4bb02e-268a-460f-7076-08da124bc6d2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6446.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 12:49:52.3898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CK9K6kCP5/iwsJVzFpCEEPfN/0UC16xIPqmWnAJhzSUk6iuA/J+ATm96s+65beYNk6zU0HeDqdCjw+usdN0IqdlXLnkJZ1aPKhWHeMC3S2ik1gphMrk1geALrLYMo7jF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB6999
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/30/22 3:45 AM, Leon Romanovsky wrote:
> On Tue, Mar 29, 2022 at 02:42:21PM -0400, Dennis Dalessandro wrote:
>> Remove Mike's contact from maintainers file.
>>
>> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>> ---
>>  MAINTAINERS |    4 ----
>>  1 file changed, 4 deletions(-)
> 
> What about rdma-core?
> 
> Thanks
> 
On the way.

-Denny
