Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B53523BD93
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Aug 2020 17:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgHDPuu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Aug 2020 11:50:50 -0400
Received: from btbn.de ([5.9.118.179]:37822 "EHLO btbn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgHDPuq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Aug 2020 11:50:46 -0400
Received: from [IPv6:2001:16b8:64d7:4500:fc3b:cfd2:151e:7636] (200116b864d74500fc3bcfd2151e7636.dip.versatel-1u1.de [IPv6:2001:16b8:64d7:4500:fc3b:cfd2:151e:7636])
        by btbn.de (Postfix) with ESMTPSA id A18424EC20;
        Tue,  4 Aug 2020 17:50:44 +0200 (CEST)
Subject: Re: NFS over RDMA issues on Linux 5.4
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <8a1087d3-9add-dfe1-da0c-edab74fcca51@rothenpieler.org>
 <CE6C02CE-3EEB-4834-B499-376BC6020A17@oracle.com>
 <20200804093635.GA4432@unreal>
 <92a5a932-b843-eed3-555e-7557ccc1f308@rothenpieler.org>
 <20200804122557.GB4432@unreal>
 <DAF6EFDA-5863-4887-B495-0BE3CA714209@oracle.com>
 <d41ac40e-8974-0a44-2b9f-bede74619935@rothenpieler.org>
 <F6BDB1B6-6315-47C9-A589-F4A57E25B2C5@oracle.com>
 <20200804134642.GC4432@unreal>
 <45BA86D8-52A3-407E-83BE-27343C0182C5@oracle.com>
 <B82C41F6-1C23-44F5-B802-621F6B63E12F@oracle.com>
 <7c7418cb-7f7a-5de3-2025-7bde5cd5ac2a@rothenpieler.org>
 <4751E7F5-AAB1-4602-B926-9BB08E1D213D@oracle.com>
From:   Timo Rothenpieler <timo@rothenpieler.org>
Message-ID: <074fb120-1807-3d83-f34e-400e05cbce27@rothenpieler.org>
Date:   Tue, 4 Aug 2020 17:50:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <4751E7F5-AAB1-4602-B926-9BB08E1D213D@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 04.08.2020 17:46, Chuck Lever wrote:
> 
> 
>> On Aug 4, 2020, at 11:39 AM, Timo Rothenpieler <timo@rothenpieler.org> wrote:
>>
>> On 04.08.2020 17:34, Chuck Lever wrote:
>>> I see a LOC_LEN_ERR on a Receive. Leon, doesn't that mean the server's
>>> Send was too large?
>>> Timo, what filesystem are you sharing on your NFS server? The thing that
>>> comes to mind is https://bugzilla.kernel.org/show_bug.cgi?id=198053
>>
>> The filesystem on the server is indeed a zfs-on-linux (version 0.8.4), just as in that bug report.
>>
>> Should I try to apply the proposed fix you posted on that bug report on the client (and server?).
> 
> If you are hitting that bug, the server is the problem. The client
> should work fine once the server is fixed. (I'm not happy about
> the client's looping behavior either, but that will go away once
> the server behaves).
> 
> I'm not hopeful that the fix applies cleanly to v4.19, but it
> might. Another option would be upgrading your NFS server.

It's running on 5.4.54 and the patch applies with no fuzz whatsoever:

> patching file fs/nfsd/nfs4xdr.c
> Hunk #1 succeeded at 3530 (offset 9 lines).
> Hunk #2 succeeded at 3556 (offset 9 lines).
> patching file include/linux/sunrpc/svc.h
> patching file include/linux/sunrpc/svc_rdma.h
> Hunk #2 succeeded at 172 (offset 1 line).
> Hunk #3 succeeded at 192 (offset 1 line).
> patching file include/linux/sunrpc/svc_xprt.h
> patching file net/sunrpc/svc.c
> Hunk #1 succeeded at 1635 (offset -2 lines).
> patching file net/sunrpc/svcsock.c
> Hunk #2 succeeded at 660 (offset 2 lines).
> Hunk #3 succeeded at 1181 (offset 4 lines).
> patching file net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> Hunk #1 succeeded at 193 (offset 2 lines).
> patching file net/sunrpc/xprtrdma/svc_rdma_rw.c
> Hunk #1 succeeded at 481 (offset -3 lines).
> Hunk #2 succeeded at 500 (offset -3 lines).
> Hunk #3 succeeded at 510 (offset -3 lines).
> Hunk #4 succeeded at 524 (offset -3 lines).
> Hunk #5 succeeded at 538 (offset -3 lines).
> Hunk #6 succeeded at 578 (offset -3 lines).
> patching file net/sunrpc/xprtrdma/svc_rdma_sendto.c
> Hunk #1 succeeded at 856 (offset -15 lines).
> Hunk #2 succeeded at 891 with fuzz 2 (offset -22 lines).
> patching file net/sunrpc/xprtrdma/svc_rdma_transport.c
> Hunk #1 succeeded at 81 (offset -1 lines).

I will deploy the patch to both server and client and report back.
