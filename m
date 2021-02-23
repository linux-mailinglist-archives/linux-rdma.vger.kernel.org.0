Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36ABA322BA4
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Feb 2021 14:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBWNq0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Feb 2021 08:46:26 -0500
Received: from heimdall.rz.uni-duesseldorf.de ([134.99.128.243]:14086 "EHLO
        heimdall.rz.uni-duesseldorf.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229952AbhBWNqY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Feb 2021 08:46:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by heimdall.rz.uni-duesseldorf.de (Postfix) with ESMTP id C5838D005EC4;
        Tue, 23 Feb 2021 14:45:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at rz.uni-duesseldorf.de
Received: from heimdall.rz.uni-duesseldorf.de ([127.0.0.1])
        by localhost (heimdall.rz.uni-duesseldorf.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7CcpgZJUr37I; Tue, 23 Feb 2021 14:45:39 +0100 (CET)
Received: from [192.168.2.126] (aftr-37-201-225-45.unity-media.net [37.201.225.45])
        (Authenticated sender: krfil100@uni-duesseldorf.de)
        by heimdall.rz.uni-duesseldorf.de (Postfix) with ESMTPA id 720F2D005EB1;
        Tue, 23 Feb 2021 14:45:39 +0100 (CET)
Subject: Re: ibv_rc_pingpong fails to create a completion queue
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
References: <0fe96275-9413-18a7-8ec0-d6b456dd1f26@hhu.de>
 <CAD=hENcBOO3KfH4wHoz1GBz9LPVZ5BOnoyPq8MMtbhB0DA=F5w@mail.gmail.com>
 <YDTDLd8cvGUgtkqb@unreal>
 <CAD=hENfGaH00Y52ped7v1uQtiDwaHUFMxMjGMJYLjp_L0hSmEw@mail.gmail.com>
From:   Filip Krakowski <krakowski@hhu.de>
Message-ID: <d976bf77-c291-11a5-a8d4-8bbfd149a2d8@hhu.de>
Date:   Tue, 23 Feb 2021 14:45:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAD=hENfGaH00Y52ped7v1uQtiDwaHUFMxMjGMJYLjp_L0hSmEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

"I use the kernel 4.18.0-240.10.1.el8_3.x86_64 to make tests." was the 
line that solved this problem.
I never thought I would be stuck with a problem for a week caused by the 
kernel...

That said, updating the kernel to "4.18.0-277.el8.x86_64" solved the 
problem.
Thanks for answering this fast and sorry for taking your time 
considering the trivial solution.

Best regards
Filip

On 2/23/21 10:50 AM, Zhu Yanjun wrote:
> On Tue, Feb 23, 2021 at 4:56 PM Leon Romanovsky <leon@kernel.org> wrote:
>> On Tue, Feb 23, 2021 at 11:08:18AM +0800, Zhu Yanjun wrote:
>>> On Tue, Feb 23, 2021 at 12:21 AM Filip Krakowski <krakowski@hhu.de> wrote:
>>>> Hi,
>>>>
>>>> whenever I try to test a reliable connection using "ibv_rc_pingpong -d
>>>> mlx5_0"
>>> ibv_rc_pingpong -d rxe0 -g 1 > /dev/null &
>>>
>>> ibv_rc_pingpong -d rxe0 -g 1 192.168.1.2
>>>
>>> I made tests with the above. It can work well.
>>>
>>> Normally "-g" is needed.
>> "-g" is needed because you are running RoCE, while Filip is running IB.
>>
>>> Before directly using mlx5, please make tests with softroce firstly.
>> Are you sure that RXE works in 4.18.0-151.el8.x86_64 kernel?
> I have no 4.18.0-151.el8.x86_64 kernel at hand.
> I use the kernel 4.18.0-240.10.1.el8_3.x86_64 to make tests.
>
> SoftRoCE can work well.
>
> Zhu Yanjun
>
>>> Zhu Yanjun
>>>
>>>   to start the server side the test immediately stops with
>>>> "Couldn't create CQ". Since I couldn't find a solution for this problem
>>>> in one week I would like to ask if someone has encountered this error
>>>> before or knows a way of troubleshooting it. Just to be sure I updated
>>>> the controller to its latest firmware (16.29.2002) today, but the error
>>>> remained the same.
>>>>
>>>> System Information
>>>> ====
>>>>
>>>>       * CentOS Linux release 8.1.1911 (Core)
>>>>       * Linux 4.18.0-151.el8.x86_64
>>>>       * ConnectX-5 (MCX555A-ECA)
>>>>
>>>>
>>>> Installed Packages
>>>> ====
>>>>
>>>>       * rdma-core-32.0-4.el8.x86_64
>>>>       * libibverbs-32.0-4.el8.x86_64
>>>>
>>>>
>>>> Loaded Kernel Modules (lsmod | grep -E 'rdma|mlx')
>>>> ====
>>>>
>>>>       rpcrdma               274432  0
>>>>       sunrpc                454656  22
>>>> rpcrdma,nfsv4,auth_rpcgss,lockd,nfsv3,rpcsec_gss_krb5,nfs_acl,nfs
>>>>       rdma_ucm               32768  0
>>>>       rdma_cm                69632  5
>>>> rpcrdma,ib_srpt,ib_iser,ib_isert,rdma_ucm
>>>>       iw_cm                  53248  1 rdma_cm
>>>>       ib_cm                  57344  3 rdma_cm,ib_ipoib,ib_srpt
>>>>       mlx5_ib               327680  0
>>>>       ib_uverbs             147456  3 i40iw,rdma_ucm,mlx5_ib
>>>>       ib_core               356352  14
>>>> rdma_cm,ib_ipoib,rpcrdma,ib_srpt,iw_cm,ib_iser,ib_umad,ib_isert,i40iw,rdma_ucm,ib_uverbs,mlx5_ib,ib_cm
>>>>       mlx5_core             798720  1 mlx5_ib
>>>>       mlxfw                  24576  1 mlx5_core
>>>>
>>>>
>>>>
>>>> Infiniband Device Info (ibv_devinfo)
>>>> ====
>>>>
>>>>       hca_id:    i40iw0
>>>>           transport:            iWARP (1)
>>>>           fw_ver:                0.2
>>>>           node_guid:            3cec:ef0d:51c3:0000
>>>>           sys_image_guid:            3cec:ef0d:51c3:0000
>>>>           vendor_id:            0x8086
>>>>           vendor_part_id:            14290
>>>>           hw_ver:                0x0
>>>>           board_id:            I40IW Board ID
>>>>           phys_port_cnt:            1
>>>>               port:    1
>>>>                   state:            PORT_DOWN (1)
>>>>                   max_mtu:        4096 (5)
>>>>                   active_mtu:        1024 (3)
>>>>                   sm_lid:            0
>>>>                   port_lid:        1
>>>>                   port_lmc:        0x00
>>>>                   link_layer:        Ethernet
>>>>
>>>>       hca_id:    i40iw1
>>>>           transport:            iWARP (1)
>>>>           fw_ver:                0.2
>>>>           node_guid:            3cec:ef0d:51c2:0000
>>>>           sys_image_guid:            3cec:ef0d:51c2:0000
>>>>           vendor_id:            0x8086
>>>>           vendor_part_id:            14290
>>>>           hw_ver:                0x0
>>>>           board_id:            I40IW Board ID
>>>>           phys_port_cnt:            1
>>>>               port:    1
>>>>                   state:            PORT_ACTIVE (4)
>>>>                   max_mtu:        4096 (5)
>>>>                   active_mtu:        1024 (3)
>>>>                   sm_lid:            0
>>>>                   port_lid:        1
>>>>                   port_lmc:        0x00
>>>>                   link_layer:        Ethernet
>>>>
>>>>       hca_id:    mlx5_0
>>>>           transport:            InfiniBand (0)
>>>>           fw_ver:                16.29.2002
>>>>           node_guid:            0c42:a103:0054:74ca
>>>>           sys_image_guid:            0c42:a103:0054:74ca
>>>>           vendor_id:            0x02c9
>>>>           vendor_part_id:            4119
>>>>           hw_ver:                0x0
>>>>           board_id:            MT_0000000010
>>>>           phys_port_cnt:            1
>>>>               port:    1
>>>>                   state:            PORT_ACTIVE (4)
>>>>                   max_mtu:        4096 (5)
>>>>                   active_mtu:        4096 (5)
>>>>                   sm_lid:            8
>>>>                   port_lid:        196
>>>>                   port_lmc:        0x00
>>>>                   link_layer:        InfiniBand
>>>>
>>>>
>>>> Best regards
>>>> Filip

