Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5C901510BD
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 21:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgBCUEM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 15:04:12 -0500
Received: from mail-eopbgr40047.outbound.protection.outlook.com ([40.107.4.47]:44894
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726278AbgBCUEL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Feb 2020 15:04:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STlBJU15CrB7PsLzPudtlHzJHjMeTc6DusouUhrbHSiBUckJI7nMqDzroN7xIced+q+Vscc9zi154k3YVXDa2DtMWbP7Rt2qEOMurELHq0L0BQdjy4VtGF0cudKNfcHiyQ3vJc+ts+K9olTh1ifJIpfvabaiemrDwCtDMJC4l9pj6zNBcIfcylUXYEw8asja8qYjxQ80lcRESJw0ox9etOtAQb/7d5Hg2cyvqh1YUuxmzVUk2vmkg3DfUoMth/rxtIpMeTdFfaXQldYjA4NU0wUcwu72sVKtv333aDq0eSQKWB3spGWaZWanMDSx6AmOk+mfQiT7J/a8z8b6RHr8sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bgde8LfcnhGPXphLeJjK6FNf7JnKn0uUjQJfxiMmOvo=;
 b=aLrDbLWNxqdqdsSF2MO1KNpQTcMUU/n0WzwxNfuqTtCZ2yaY9JU97gzI+IiyGc0ws4j9SebpymDg+8Robyj1LFCkT/Xb3cPAxW2/uoLYvBK1BqH/1O6HBEq9ACp5GCElxN0Rlkv46274oVQkccGsPbRccO5ODp2G5NOjzVGfZiOkhwut0cKhxsRnfaYErU2T7gVrbtUhUQ49oM83FEQb/c9Cv0tz69lcwk9Cwl35qUuuyxMnDUHPXc0BhMFTHOo/UpTxfMZtFfW9luWYTxNBHQuD7nGC2Qmzf7Jgk5cQuShNf4ki/WebMP+pzDndwQzMJ6ipGrvWmV0/z5Qj2sByxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bgde8LfcnhGPXphLeJjK6FNf7JnKn0uUjQJfxiMmOvo=;
 b=JlY4n6IfgLt2bcphesjQxiVo2Dmt/kW1MvBfSgbiYOM97eI/9f+8SiJZKRv8T/cUPb4nvqYASZUMe6ZhSo3LSzAfN4jUQu9hy77oadtKVobJmD9ZTpqFuR2H0sZX3RwjnC5fVDqQq7m7YFN0Nintrkhu11KuuxlA0PEEltPAXMs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=markb@mellanox.com; 
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com (10.170.238.143) by
 VI1PR05MB4815.eurprd05.prod.outlook.com (20.177.50.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Mon, 3 Feb 2020 20:04:07 +0000
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4f5:b09a:60c5:26f]) by VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4f5:b09a:60c5:26f%7]) with mapi id 15.20.2686.030; Mon, 3 Feb 2020
 20:04:07 +0000
Subject: Re: RDMA header inspection
To:     Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>,
        linux-rdma@vger.kernel.org
References: <CAOc41xG5xb-6LEKmsvPPET9jKZ8ScAMW1rW=AzV1_HLs9DhNEQ@mail.gmail.com>
From:   Mark Bloch <markb@mellanox.com>
Message-ID: <0e404cd8-f993-cfe9-34b9-16cdbc82442a@mellanox.com>
Date:   Mon, 3 Feb 2020 12:04:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAOc41xG5xb-6LEKmsvPPET9jKZ8ScAMW1rW=AzV1_HLs9DhNEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR22CA0010.namprd22.prod.outlook.com
 (2603:10b6:300:ef::20) To VI1PR05MB3342.eurprd05.prod.outlook.com
 (2603:10a6:802:1d::15)
MIME-Version: 1.0
Received: from [10.9.98.14] (208.186.24.68) by MWHPR22CA0010.namprd22.prod.outlook.com (2603:10b6:300:ef::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29 via Frontend Transport; Mon, 3 Feb 2020 20:04:06 +0000
X-Originating-IP: [208.186.24.68]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8533b9ec-78b9-49bf-eebc-08d7a8e439b1
X-MS-TrafficTypeDiagnostic: VI1PR05MB4815:
X-Microsoft-Antispam-PRVS: <VI1PR05MB48156242A393D7F0BC493138D2000@VI1PR05MB4815.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(199004)(189003)(3480700007)(966005)(478600001)(36756003)(7116003)(52116002)(5660300002)(31686004)(66556008)(4744005)(2906002)(66476007)(31696002)(66946007)(86362001)(6666004)(6486002)(55236004)(26005)(16526019)(186003)(16576012)(53546011)(316002)(81156014)(81166006)(8936002)(8676002)(2616005)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4815;H:VI1PR05MB3342.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLEXf8vQHhy5PUUyjY6HT9hFLBdfnJXlwqLAUS8Rausmelnuu42W8dlupye9ZvQWVb0QCLNvt+ZvSN+yJECxz6OLt2EY8kvPhGaO97uK/4Z3x7/QfNTuTSDRG1lHReslbekpF4YWyF93XZfQW/nBEtsVWXiICbKcTGrNKmaFLKIzCuZbvepyrWch/nwYR2mbMb+BPuuvuI5B5JnN1gp/9Wk+z1h/rAR0/UAuTVNjbBLHeAZMaMAO1Maj3yFh8LykXUw1VMXb+p7AlIhXXOlwscxgWu/Ks6sKIky/4f7EbNVphSOhAjCbvIGk7TtUGhQtpB5Qf4pA4LSIq129SxFVWyaL57z4or2L/wxC5tRDiI95OCtGgCHQxpJfSRxTRQFaqvdUYT5BtYUQsYI/he6CTiUGb6kyA77Rp+/IcoSG/qwCPK7TSZiFeWJDaFvYaXHEC2dEKen/G+iZ8m2KdA0XBxylrxurEgLzPNWPss0eEh41zqVrmX06SjqbSWX0Kntzjj7RvVXF/Gy9hmB+x8n+6Q==
X-MS-Exchange-AntiSpam-MessageData: FK94adAjSO40EIqMswNSLnEWGM/j1irYSgXtw5ipgdtNf83yxEutfZ7GOresqaE78V4CumVhAvGQ/DKeOup0P2ZirKSwkEyW4Dx2oovimCDRru6zlaJ60DWHSBbJMVhRVHvJ9oLa0CdAHLBGrs8U6w==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8533b9ec-78b9-49bf-eebc-08d7a8e439b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 20:04:07.1605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkwN8yPOIkWsCMsrMuRB1Nyuv4VxhhY/WnoO0TJW43JopriXa829Kizqk8QfeOUj9g5exJHxHCSCJl0KKkOrGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4815
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/3/20 11:30 AM, Dimitris Dimitropoulos wrote:
> Hi,
> 
> I'm trying to inspect RDMA headers and they do not show up on
> wireshark. How can I observe RDMA headers ? Also, any header parser
> available in the code base that I can link to and use to process the
> headers ?

Usually RDMA packets will not be seen by the end nodes.
What is the link layer IB or RoCE?
If RoCE and you have a switch in the middle, you can probably run wireshark/tcpdump there.

If you are using a driver that implements the right flow steering API you could use libpcap:
https://github.com/the-tcpdump-group/libpcap

The APIs used:
https://github.com/the-tcpdump-group/libpcap/blob/master/pcap-rdmasniff.c

> 
> 
> Thank you.
> 
> Dimitris
> 

Mark
