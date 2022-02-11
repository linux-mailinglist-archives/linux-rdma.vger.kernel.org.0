Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2034B2E1C
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 21:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353067AbiBKUBc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 15:01:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353057AbiBKUBb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 15:01:31 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2059.outbound.protection.outlook.com [40.107.96.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC8FC52
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 12:01:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqdB4QCKQvm650rQOVRXEVudZYHda+ImXmBCyeAc3rUPo858pdxV/IhBlV17BFkA0uBVupw7PS5ac011SF6YJLM1l0cCgjJrxK+NmSvD8yKZJoVVXTACnjWVV5aK21yn3Cx8BHWnUP56BYvhYzTvKJbwND4TsqXYJ2Yblm9GujuqrQCbg3XbGdyeF5yArRofCPmJ2pRSSJjbBcTCal8ODU9HQ3X2NaSSDFPYO+BUdjF/RIONGVdTdJHGE526YvTtjF2Xqoeco/dTLPzOTvWU6HM0OEHlF7gJ2OnRrgZ6+XbIJCC9SEgshByLi14s5hdznnwrMqKMHZSsHwueASLnPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHDzby1HB7zGjamXIQ22Yq7bNTd9DwLurs32TFVMNoQ=;
 b=VSCNXHYZ4hmPiQ9FELsUDRIlbjzR9vuCjIlqRwTgtT0in/tTy50NTmz05yLAP1aovGzy69BJDTt4Y/UhKrmBElgid23UkY2WmmhL0GNAdHpUeUJRMf7Rp5/r1ZwnNRz9+6CIwyWJpXveGhcSNV8gkYP3e9dxC+n4dhnf141abEgSQk6vNzS+eTdSjuf47tkIgTPvuhVgR8HApKEH9GHwjyQVvwmuBCRKQB0O+Jn2jXSYRNsAWM4UuoqV8ZHhzDIJLqX1qgdXHGVeviZQP9lFNr7crrqPQJc7LGyLc5DxHQXkJF3GwFQzW9EAItPlDjAJJQFnXTw2NNQn641nPEzqnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHDzby1HB7zGjamXIQ22Yq7bNTd9DwLurs32TFVMNoQ=;
 b=BCMUWVxHLG99xJmIduV0bIg+snP8N/XLvnkYgZVLM/iZ9ZBG8UEoWVRc0O6WA4Suv+JeERFMkV5rmQBqyOB56vN/0R6HW502C08rAZQ/NULUWtTBbyQupckCxePMPn/5Oq8FEEBt9wBs4A1KXMUmpdPLgNYa5wIfuDuvas+b2pOu+rzlxUqfDE+qNVTfzoFviufYozi7XkzeZU5WNIlE7Yhnjif4cn1SMtLMgLXHyiSrhh9sNxryODmeNjx4zMdDH3c9PVnO+iB8+P94yhqfpyGdGvgpB6bcn06kpbic2N5NNU1Q4YAf+Js8QvLzpNI4Jmwfeuk+/NM/RVpllSiwBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1162.namprd12.prod.outlook.com (2603:10b6:3:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 20:01:28 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 20:01:28 +0000
Date:   Fri, 11 Feb 2022 15:56:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v11 08/11] RDMA/rxe: Add code to cleanup mcast
 memory
Message-ID: <20220211195627.GR4160@nvidia.com>
References: <20220208211644.123457-1-rpearsonhpe@gmail.com>
 <20220208211644.123457-9-rpearsonhpe@gmail.com>
 <20220211184301.GA576950@nvidia.com>
 <a34545c4-dd47-2613-e08a-cfbc3ce0d32c@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a34545c4-dd47-2613-e08a-cfbc3ce0d32c@gmail.com>
X-ClientProxiedBy: BL1PR13CA0067.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::12) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb242f5a-ecaa-425e-0f9d-08d9ed994a8a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1162:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB11626FEF3734F119021DDD0DC2309@DM5PR12MB1162.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3FViEQ/pNWyvDhfNU7VZb8EoPDVqNVGz4eEcfm/cjEx6GMH/krXG+2ZZygWFXtoiWUG4DG5O4DQO992M9Zs8tIlM4yDfygJBVBuWXFxgcp41QQCFt6wthUXWgrKPjONmLqvEd6xauKu2B5LlMQhglk7f/Qa9OA3QY/iN5tbVL5xm2nOD97j9+3LIMdzuCIsXQjWspWMKfdGhwd86Uc0VGmtoHB/XZluBnuh41MfQQk7V3F1nX1yiN+7YgpIyQbXokhgPy3jaUQGncHtkHpmfIcilyYOfIUhZ1/9YQn3PV+Dk2XlV7m+DSiWptPT85zX5+9NH/0PEadZr7kNol9PXiCiMJ5V5Zqh/a+6bekZx/Xi0bXNyRyb/Jqp7UO/yJnmgsgZ042HLJegzdHoKF2pTNwmMCNJ0Se/j3OyyLIceTghYQaCsZHd7sytDz4DF+678Odiy45xvwryEzm0pMhjqAULlN1SIbw1tAXJbp6vAQaIu68rmbaYo1/hM6FM2W/qQND8yzzqQVDWuSgnsCs2BcBlScUmUfFkzwDfKc/KdgRNFNCvUkeshlCmIQQB5AtnMEWoUpGY7Pt+x7Ize2jq6esp3/X7y+nW4/z/80oJWksqBQu5go3kiBvwSVUp+MtsWcxqJa+iLR2bjL9O6C1ETg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(2906002)(33656002)(186003)(2616005)(26005)(1076003)(36756003)(66946007)(6916009)(316002)(53546011)(66476007)(86362001)(66556008)(5660300002)(8936002)(6486002)(6506007)(4326008)(6512007)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zOxpxva9ZhbzQ1zEsp4o/xxT7n6a2rs25BRFFDqhNDeTTA1drXyEZyHnUVFy?=
 =?us-ascii?Q?TZdwMLelukvWrHTh5MPJQZqYaX9VLiXZkFwgyNHxoVRlGzfJvItx+XcJHhdY?=
 =?us-ascii?Q?tTYFOhyOphallcGVEDkFJMLggj8j2zAjJ5dYy4CRrLqy47TMUuPbxKyUlyMC?=
 =?us-ascii?Q?Jk4P/AigIlOKvjqv8dR26+oS7eXkCciCHkpr8vHSPRAjtjEifidb5V1UAEsk?=
 =?us-ascii?Q?ZB0AU555KZpdOeCyQdEVdM1a+QGd4R133FsdgHLAKxfMvjU7K3wKLnQuZP+L?=
 =?us-ascii?Q?B33QxFfqXjgRf4IkG6JKI508W9fRJ7yUrFNvcsrPxOCmg6eiXetLuT5WhG96?=
 =?us-ascii?Q?eIBv2fUbnhzHHGqQsl+z1GDmkUlzZPnvAz+oGywg8VlRwqrR8cwVu/98bkZR?=
 =?us-ascii?Q?djVhjIvB3LxwOpcHr7DFJsxl1jbDoB/jl6d/dYIlJa8VQAjpbdK4djzgPah7?=
 =?us-ascii?Q?oKzauQe8NOwWUosQwg2FjVq6D6lzwMurzA56mQxXqzY4nbVV07Ah2pYqgJTr?=
 =?us-ascii?Q?OvdbUkUF/2+QcgGvYA3XrONjZI+AucxwkmrtRxdIcrIGlG2Jwfx2MZFXESVQ?=
 =?us-ascii?Q?pzdshyLU0HtAa4DX7Wy+kzyPPpOCIkLDOUw4lN6NpDWnYbqsc4pNeCAJqWoJ?=
 =?us-ascii?Q?Zwjl/oZZRxGAstl+fWtAsYzc1S3W6ga4959+2neDrqqFoibYclPKfDNzF/Sq?=
 =?us-ascii?Q?lMMXM9jRDPs4hTBR3VB0JMF7kHuSviyRsR9FoV6dhRl8eaSrW5H13sEJqlWT?=
 =?us-ascii?Q?szU8Tx+vtoWNCCsR08fKjoiS4nmdcX/yEPG6rabl5x9+CqvbYk0asschFfIn?=
 =?us-ascii?Q?NiXDh5y9l/hCnWG95jqeHLW9mT912hcJQwberQDr+uc/r28m66L09Ge0eHDf?=
 =?us-ascii?Q?H5LdKdPi6K556xNbRbn8cmZnPkMs60/t3G9M7C2aXgrnTEsUTZ7C3DeWAVPa?=
 =?us-ascii?Q?iGYPGArc/FTD3sCV9UQiNnBW05PD3+pWQBMLwrSLAcCjaIAj3u3tT7hKrvjc?=
 =?us-ascii?Q?8d9BDUmZ870YyhSazRAyggAaQ1kzrw8MFl0aupxr0hoOe6ZDztFeFTzm1EbX?=
 =?us-ascii?Q?+nryXiYqfpiCUPCkyNscW4h1yvQE2lbJxZRDS8IBeEAWbEQsY64f9/YkAg8E?=
 =?us-ascii?Q?q5u2SdBv/KaLY3pwMONZ86F0FgVywcmT1tvqKf5GmsXsJje3ZF1/pE4NCrRL?=
 =?us-ascii?Q?AQYV7Dm+bPU3iMOYzVzlr57O/b4s5zztBi/lq7IHvV26yk1GmTrFEVVAcm1s?=
 =?us-ascii?Q?mg3gdWN+ysfrxefMUq9nBD6EYSZUtAyTqrN+t0NcXmF+3MkihEWPMakWgyFt?=
 =?us-ascii?Q?D56gRv6HXD+FqZds4x53aAbbYUmF0d3WOg0vxZAfRLfbDhAMxyfShnQoH8N3?=
 =?us-ascii?Q?/ES9/nw/rBKZGf1+nGEJ3fp4AAk/kUWodPj1pBy0iyAFv0GDW8AMOyFQSh1f?=
 =?us-ascii?Q?tE9rQN0E9HESAe9jLfqwZeDIRYr0ciOthiGOzELrKIoYtZZgG7Ggog2XCM4q?=
 =?us-ascii?Q?wVD8+IvAooUQQgyFD7LZMCrd9vsQWFhgGEmNDYkJrxfBUfWGYGZkvCPg2USr?=
 =?us-ascii?Q?z0KfA3Tkn6PWmaVwgCg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb242f5a-ecaa-425e-0f9d-08d9ed994a8a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 20:01:28.8476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8++hT0TLwgFVp+sodKuXDpzwV5k74mXB85L1xW22SFFH+iwZH6pydgzbz2GLfLJ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1162
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 11, 2022 at 01:36:06PM -0600, Bob Pearson wrote:
> On 2/11/22 12:43, Jason Gunthorpe wrote:
> > On Tue, Feb 08, 2022 at 03:16:42PM -0600, Bob Pearson wrote:
> >> Well behaved applications will free all memory allocated by multicast
> >> but programs which do not clean up properly can leave behind allocated
> >> memory when the rxe driver is unloaded. This patch walks the red-black
> >> tree holding multicast group elements and then walks the list of attached
> >> qp's freeing the mca's and finally the mcg's.
> > 
> > How does this happen? the ib core ensures that all uobjects are
> > destroyed, so if something is still in the rb tree here it means that
> > an earlier uobject destruction leaked it
> > 
> > Jason
> 
> The mc_grp and mc_elem objects are not rdma-core uobjects. So their memory
> is allocated by the rxe driver. They get created by ib_attach_mcast and destroyed
> by ib_detach_mcast. If an application crashes without calling a matching
> ib_detach_mcast for each attachment the driver would have leaked the memory.
> This patch fixes that.

The mcast attachment is affiliated with a QP, when all the QPs are
destroyed, which are rdma-core objects, then all attachments should be
free'd as well. That should have happened by the time things get here

I would expect a simple WARN_ON that the rb tree is empty in destroy
to catch any bugs.

Jason
