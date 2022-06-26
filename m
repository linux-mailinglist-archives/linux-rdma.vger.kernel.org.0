Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0F155B1C6
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jun 2022 14:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiFZMLj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jun 2022 08:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiFZMLj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 Jun 2022 08:11:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B321C9
        for <linux-rdma@vger.kernel.org>; Sun, 26 Jun 2022 05:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/jsVBrw8npmINYFhORshd+F2C6q5XAaLhRsXyBSdI04NsaArccgDRZUnXisFEunonP4VL4yAZoqJZ5DDMfsSVaDK0Kzt0jLl/11TLWnKAsHfoiM4/eeWvsiOQinZhZL7LQ5QYgcyd0zona3q7DI/7je9QilUvsryBmS1Oe1xAdBxYq51yer/sNC0JoqwOGbRVa02DCb11XYRONQObdP3K+3cHUb3hc/mSM+PQ7g5ErUwlQ6nSMwuCh6a+anEVlqBJ1AzC32KWMIbH5DnYoxsvf3MKtgBufahIYs69FPIUH+dl/orRvRml2xnqJlmuccEkQGz01wAZPo2Ad1bCjI3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gREFsNbllfAtaFhjag9LQsevzTOcmYwttdcOWSlGzM4=;
 b=XJ+Ht67MHtvNCCt+KTlwsZmud8g8+9s+059oPGNfNABYgD2wDnsvKlwQb6nT2yDJrsjoG8R2bIPrp3mw/DH/R8ONlcD09Hvc2WejSXsJc+lAtNXlu8I0N7fy1POu4uoZDlpqOJh5ppz4P764CGPPTiHwxYqGAFz5ZY/RdIsG3tbeEY9TXL4jvbqVcRQ7a8sRt+769vU7SDYhdsnc9kBgo6uLu8j/g/TMlZ/Sf7EUZCKF2IHg3P07J+ZAqeDyNnG/JNbJB1C9grHLYYcCy6ZqYzmfkRG3CoIugv26PPxhB2nNVDz6ERpMHy3PFzeDbAif9RB2En6thbxsj/wJGU/iDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gREFsNbllfAtaFhjag9LQsevzTOcmYwttdcOWSlGzM4=;
 b=QAd77YwNddfxBiXa60Sp2sEopRiIzhsq/YW3uchOnpuAdPUfAQYMEx/8gEh1aNDfVoxezbqg/OEXRZs2i1A4HIPxdjUTiWZsk7BEOfxGxXeLT5Krz4jFrB4axmGtF8sDp95RZcVV8TsbTZBtN6cyXqL/iU6n03kmjKFHkOXbbI9Jz0VUEKXRbqlDny/Jr+T2V1KkXd2EIY5t1aL+ZvxBaM243jwKu1EIGAsyyP7dWeyfEEf4C5PzMSuD9eHUDoAAIGW1nAOVzNODd/mHj8GIkl2gRjoaHGFI/BOVrBUb1hutRWs6c79Sx6OcOqYYwWn1i/D2WhqHcvZPGDbnTpP2DQ==
Received: from DS7PR03CA0357.namprd03.prod.outlook.com (2603:10b6:8:55::10) by
 MN2PR12MB3342.namprd12.prod.outlook.com (2603:10b6:208:c3::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Sun, 26 Jun 2022 12:11:35 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::fb) by DS7PR03CA0357.outlook.office365.com
 (2603:10b6:8:55::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Sun, 26 Jun 2022 12:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Sun, 26 Jun 2022 12:11:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Sun, 26 Jun
 2022 12:11:35 +0000
Received: from [10.80.0.165] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 26 Jun
 2022 05:11:33 -0700
Message-ID: <be0f2b99-04da-e039-37fd-cbd15a9fccbe@nvidia.com>
Date:   Sun, 26 Jun 2022 15:11:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: pyverbs: rdma_connect/accept with private data
Content-Language: en-US
To:     Changcheng Liu <changchengx.liu@outlook.com>,
        <linux-rdma@vger.kernel.org>
References: <OSZP286MB16299D300C8880F6E27AB2A5FEB69@OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM>
From:   Edward Srouji <edwards@nvidia.com>
In-Reply-To: <OSZP286MB16299D300C8880F6E27AB2A5FEB69@OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98e8d117-7a34-429b-9476-08da576d041a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3342:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGXKTNjfUTAJwq+AxpQUe/awpqwB3Ln8BvPsoA5CuuhF1vBvbtcTO8blGoFedDlEedtCA1OcFOygFS4zLd9rS0mupp+Gdkj3bmGCL94QCieNXaJbtj7bc9w64J+zy0S1Ny8ISICa2M7tFHFqqeeE5nQ10mumPaN1Y7oLsddINtUBRoSvwRXiAy7GjLkYGRg2URZAjfO+r40f00gxXVZCNspucCxLTZgwoVIDkKk4530w2N4yj1ryVCY8ZZIUpt+yCmH+sIKQeyzPiwzNHqyX532oYp8IrqkRfzvXOZqBrFy64b+BBLcLsNvqA/CQ/TlU+yZMcXSlNn5qDgYdthnTknALrE/bbWNY/ax9223E+JJBVAWFN7rY2hLX/1OTTdex/4hASik4Ix/YRjX5ubFdeEQI8EIkJwaKmK3jfPQsCCnV3o9pOo0zaTStHoslbTIWmbaHfWBt+EUX4CTrLxboXKUxL7sNkuJS+D9NKYESmCpk48KDo67YdGHm304ndmcYCytt/gCCB44cVB77kz6GNHk9HGSpjbQ95q7TIwJTTeDt158HMsVHpTUE26ozusGdZYuGvilmKoMqIHBOGpRNptvgNGYExdsmqlSy3s/w8tdJRJiWo38irHtBaL/tjeZ6RZmgkXWFblZ2yXC7CIVU0U+lXyzDAdeo7XicyQVlUdCHgF0LRd7j+kRQNMRlre0xUbo5e/nzbL4i+aQBs/+5/CdPCRNV0yYWHZKNlem1vhpgDuq7l6AWe6W3sy6bD2R7tlWrhCAJgGsa97TPURVshUUA8ffgu6Bo5CZIiBBg9/QiPlUxsbhReWvMlPW6693fZoxUhL7w94Y4AkJTOTt7raUZ0Ues9nA2pMVyeq1cpwf31f/SigX0gFuK9x9eYOC4
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(40470700004)(36840700001)(86362001)(31696002)(26005)(53546011)(8676002)(356005)(70586007)(70206006)(8936002)(478600001)(40480700001)(32650700002)(81166007)(4744005)(36860700001)(16576012)(41300700001)(82740400003)(110136005)(2616005)(5660300002)(36756003)(40460700003)(82310400005)(316002)(336012)(2906002)(16526019)(426003)(31686004)(186003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2022 12:11:35.7155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e8d117-7a34-429b-9476-08da576d041a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3342
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/26/2022 6:49 AM, Changcheng Liu wrote:

> Hi all,
>      Does anyone know how to use rdma_connect/accept with setting private data in pyverbs?
>      I'm wondering how to set the private_data member in the ConnParam::conn_param.

Unfortunately, currently it's not fully supported in pyverbs, but it can 
be easily added.

I saw that you've just sent a PR for that :). Will take it from there.

Thanks.

>      For example, how to set only one uint32_t varible in the private_data?
>
> B.R.
> Changcheng
