Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E86E818AA74
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 02:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgCSBts (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 21:49:48 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:44896 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCSBtr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 21:49:47 -0400
Received: by mail-pl1-f180.google.com with SMTP id h11so310216plr.11
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 18:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=XOhIJUKz4PCXZxXEOXoWCJ6nIHhUfx5esbK4KlMkWgk=;
        b=nkA3MsATzj9O/lJKSJLNkssfIpG7ugOHHWBszWgxdMvggfNS8DnV+VcAx1GeTLVxbB
         iigX+yFoCei5ObamlW8jZAVJX2n1BJpSxbylQy4OVOJKygb8cOhdOO+gW2AH/cy7/J8J
         9HRV0kz2JuV963dshBi9pVOw/P9cmOS16rfAmuv0Dw19WERkYFUadKTcgXAFiC3qq7ft
         wL6M5D9qtf5ATX2z/8kIBiVZ23dQ8scC8r1tw2Ct4wUI6WHuhNOZPV/1tvHjzSuWzLQ3
         crLyA7hOmGBnuEOpN0s8boxTZuQsRGUjYmJ44dihH1sedqzEHLx6jgoe3MpfC54odpz1
         6a8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XOhIJUKz4PCXZxXEOXoWCJ6nIHhUfx5esbK4KlMkWgk=;
        b=saQ4fwyn9SJDo/iq/nrqMea8rbnv80xf4OkfYPnAlq5dslmcwlPmyZH1000FtcklzT
         hjsNnErRNjiiH+5pJPB12E4U+sGxpKb6gMsOoq2HrYbIauhPiECmPcFzYKlB5pW15rU4
         TNKy3r325cwMjjiTPgeZfpH9knWB6CFN8BeTt0pmjSSPiadOSkU3UlEtvQMOTIe7bBJY
         FMar8bWl857NcLveXLEqNSloqxOrNB+MMrAA+0WBuNc/xopKnYuMrnhBbn2IuTagQczv
         erg1GYsL5w7wi2zKmEckwxjg1c69Pbj9aRgsI26PRZQLCd6U3cffMSlo0epsKb/myiBz
         k2ng==
X-Gm-Message-State: ANhLgQ3VEO19bT1Qf99MlZXoWnLQtnDUlZ2c6+MUZkaWjmOZcUHygdwA
        L/Yuud27ikgpVFHFQNWn/SNlvDAt
X-Google-Smtp-Source: ADFU+vu1RxTodigui/Zn/olBnyvzELBze3g8eIh+f5JKM3gOEi9ZxaI73/qEhD78oMjuhR42NjFGWw==
X-Received: by 2002:a17:90b:4385:: with SMTP id in5mr1143791pjb.87.1584582584462;
        Wed, 18 Mar 2020 18:49:44 -0700 (PDT)
Received: from [10.75.201.14] ([118.201.220.138])
        by smtp.gmail.com with ESMTPSA id i2sm200263pjs.21.2020.03.18.18.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 18:49:43 -0700 (PDT)
Subject: Re: UDP with IB verbs lib
To:     Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>,
        linux-rdma@vger.kernel.org
References: <CAOc41xGSL3bYs5s9AO-3hfEwLjOy4PEdpbN8xBYMpk5j4cLQSQ@mail.gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Message-ID: <0a7c5226-baab-e65f-2706-fd7204e74924@gmail.com>
Date:   Thu, 19 Mar 2020 09:49:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAOc41xGSL3bYs5s9AO-3hfEwLjOy4PEdpbN8xBYMpk5j4cLQSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Please refer to SoftRoCE. The source code is here 
./drivers/infiniband/sw/rxe/

On 3/19/2020 7:07 AM, Dimitris Dimitropoulos wrote:
> Hi,
>
> I'm looking at UDP using the IB verbs library. If I send UDP packets
> that are intercepted by the IB verbs layer, what happens with the
> completion notifications ?
>
> For example, say I create a list of 10 ibv_recv_wr objects and each
> has num_sge = 30, with each SGE having a 4K size. And I setup for
> reception with ibv_post_recv(). If I transmit 30 UDP packets each 4K
> in size will I receive one CQ event ? Or 30 ?
>
> Will the UDP packets be written in consecutive SGEs of the first
> ibv_recv_wr object ? Or will they be written in consecutive
> ibv_recv_wr objects (in their first SGE) ?
>
> Thank you.
>
> Dimitris


