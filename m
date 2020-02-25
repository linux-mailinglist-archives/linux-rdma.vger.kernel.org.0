Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE5F16BBCF
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2020 09:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgBYIZ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Feb 2020 03:25:57 -0500
Received: from mail-am6eur05on2044.outbound.protection.outlook.com ([40.107.22.44]:38208
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729130AbgBYIZ5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Feb 2020 03:25:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvb2ihqsfYdKlH5DvP7mVDQoHg2WVMpb/fSjroYJBwpsXPSjcWE+Z1aRE6/Eb8dtyXgRu81gLMi6coyX/iSeoPmk/ag6p+P3L8Or++XpgsERYYABAxKdTpDNpG9TBEWWqhee7my9LtUPzD0OUZ82Gqo2v2L6Jmd+cpGn8NyMoyHmFG8xUpHLlZ0vYdM0uVmGAd8Q0zqWseEM51Ze3K15Q+nt12HqA7dMH5xBHKdWXugzoQ7A/EOYW5/NSAxC5uKfe84zX3ZXQfSBDd4Ov6UjxjSgUX6zTs4KDFh3/SM5jhWJ1yP0vmuXs+1Qa4wzXYsc+mxwbAcvYLtwIh/XsIhq1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbGCnod7LIftXopFuh2fTO1oCdIJFYkVS0EpfI/gbdc=;
 b=Wr40vSnXGIPdiOeNKNx+48Qf947wTvniMzWUSV2lJwFoajz3FfrCNaE9RfhI3bFsp70AeCjigeMOpQ+pW3y/7eNUlQLxwvAtDCA0DK2QWKfflh7KSbY5UymBTSenUCbtkfX/eIFL0CTUKAbM12urcUxiPoMcBHU8zb1iKPrgo294BPezn69Zkg9r2K8bdCHsZBeBivOhRA/KTNteHt1vGCSKWhbuM3QvqaXFKMtesrZMBxLC/tFMGs/F+Np8V4Rfhs3D2YYy48jInAbdHvnd3YL2X0+PhZBvvOYUi/Nrlu8kcTlHYGGKUVw18HNZVII+dcrWcXiRoagKNmzFfRqzcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbGCnod7LIftXopFuh2fTO1oCdIJFYkVS0EpfI/gbdc=;
 b=f+JWDa+aaZgscG+5V24q0ZTA3Mnqc95TVEYlXWf8ISNjQY5B+U49hYr1IobGwFdmYvjFfOrbSDoB5+gBEE/8T1/oj6EMKB20fZ9JJUGQhG+GR1j1IFKoPuxtD5oD6xxw4a1OoDLE6WSZ2FzFJBl/HM9bn07Gzct1Yb1Dqur/eh8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=haimbo@mellanox.com; 
Received: from HE1PR05MB3259.eurprd05.prod.outlook.com (10.170.246.152) by
 HE1PR05MB4571.eurprd05.prod.outlook.com (20.176.163.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 08:25:53 +0000
Received: from HE1PR05MB3259.eurprd05.prod.outlook.com
 ([fe80::fd80:38da:1f6e:cc9f]) by HE1PR05MB3259.eurprd05.prod.outlook.com
 ([fe80::fd80:38da:1f6e:cc9f%6]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 08:25:53 +0000
Subject: Re: "ibstat -l" displays CA device list in an unsorted order
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
References: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
 <20200224194131.GV31668@ziepe.ca>
From:   Haim Boozaglo <haimbo@mellanox.com>
Message-ID: <d3b6297e-3251-ec14-ebef-541eb3a98eae@mellanox.com>
Date:   Tue, 25 Feb 2020 10:25:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200224194131.GV31668@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::28) To HE1PR05MB3259.eurprd05.prod.outlook.com
 (2603:10a6:7:2e::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.223.0.75] (193.47.165.251) by AM0P190CA0018.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 08:25:53 +0000
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b99346d2-a5b1-4ff8-cd7c-08d7b9cc5453
X-MS-TrafficTypeDiagnostic: HE1PR05MB4571:
X-Microsoft-Antispam-PRVS: <HE1PR05MB4571CB471485142A30CBBB9AA5ED0@HE1PR05MB4571.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(199004)(189003)(316002)(6486002)(5660300002)(31686004)(478600001)(36756003)(66946007)(186003)(16526019)(86362001)(6666004)(66556008)(66476007)(2906002)(2616005)(26005)(956004)(52116002)(6916009)(53546011)(16576012)(31696002)(8936002)(4326008)(81166006)(81156014)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4571;H:HE1PR05MB3259.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FL2q5RKMJdn9eKmG9Qju76iJatoi3aJ75dRB3sCa+lBYH6h/cfAqmhKz1JUe0jYsV49yddms2VVCX08UZWa0RFVu9aPB7Zq7xT9QYHCiuvQP6oxj4KasiQuKiYImMPOjzCWbNanRWj13/Dg8PAy2PsnxyZ4NB1cEl3cqDCUIUelNvQR0rzwHHYiI5ysEFrURVwTAGM02YFt7CPJKR78eB4izY5ksYbkLfUbZVerSQ2V+vraB2fYWJu660zBg1PwIaz/JN3L+VlApDR5pOh9HEhaQUZniP/5qwx+O8bNVRBdpVT+Ko8GD3upP+kg3qVM2G+/r37RDAZlCoSzt3n5AA/rzPs+udmVSrz5QYcyzqGo/4AHjyAT3TW/2fMyC8Pa280pbZcVakQgNoRKpYodSddGPoaSKDtBENhn3l5hOwiOIegLWJ1ltEdgD6/VSc4Ek
X-MS-Exchange-AntiSpam-MessageData: 0qgtfA6h440sBLG68lfs4cKE8XRLBhy6y7QPXKAEiysVzsgfAjASch7tjw035hmIYoms8U3FpQKE6V3239zzFqsXZHkuStE20UVgTiAV5gci8COMBc7/S502M1hovB1NYBcADzfFdc0zI7lKV8oaiQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99346d2-a5b1-4ff8-cd7c-08d7b9cc5453
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 08:25:53.7598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAueEdVU+JOTJTERQyY2z2KbXRuzI2x7947vB4oHU3HGWN2RaCOOba8cpVSYPe6E0MY9/uP4Y+YyMEbx62VoOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4571
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/24/2020 9:41 PM, Jason Gunthorpe wrote:
> On Mon, Feb 24, 2020 at 08:06:56PM +0200, Haim Boozaglo wrote:
>> Hi all,
>>
>> When running "ibstat" or "ibstat -l", the output of CA device list
>> is displayed in an unsorted order.
>>
>> Before pull request #561, ibstat displayed the CA device list sorted in
>> alphabetical order.
>>
>> The problem is that users expect to have the output sorted in alphabetical
>> order and now they get it not as expected (in an unsorted order).
> 
> Really? Why? That doesn't look like it should happen, the list is
> constructed out of readdir() which should be sorted?
> 
> Do you know where this comes from?
> 
> Jason
> 

readdir() gives us struct by struct and doesn't keep on alphabetical order.
Before pull request #561 ibstat have used this API of libibumad:
int umad_get_cas_names(char cas[][UMAD_CA_NAME_LEN], int max)

This API used this function:
n = scandir(SYS_INFINIBAND, &namelist, NULL, alphasort);

scandir() can return a sorted CA device list in alphabetical order.

Thanks,
Haim.
