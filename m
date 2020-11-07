Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A29B2AA1EF
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Nov 2020 02:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgKGBE3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 20:04:29 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:37383 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgKGBE3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Nov 2020 20:04:29 -0500
Received: by mail-pg1-f172.google.com with SMTP id h6so2380470pgk.4
        for <linux-rdma@vger.kernel.org>; Fri, 06 Nov 2020 17:04:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kzUqApX78AxcncsIhNbEqWLvY3I2jwzXg7iE3K65YeE=;
        b=hzcX4kc6C7pUZD2Djaa3Ghop161gmTsea+iPM3MgWqYLTSgs/n76hRHXGeOknPQHHy
         vmO5UH9jPS74ml8FNrSLGp42I09uMoCvgmpVa5bUHz+ZwoIr8Z9DQrsnSM6AmkqfnBvq
         RW3I3l2OFzZ854gpWvcxc1F5Jm1mb0doUv4sfJzWgO2+c46lWXVs3VSI0DToq/HLIQBy
         JmdxkaV6vJedOUiRvnREigQXows6lsRMAR8xKsJfn5/M4is7mgAbVZXl+Q0tw/83Dg2+
         cfA85XnSxCMcpq4+xGTJM+k6mBOg+qK59ceUFty2h0e5w3z+7EupkNP8r+jCOGWdb4UC
         zZXA==
X-Gm-Message-State: AOAM533Ssju4UpJYq9J7axjcxbUJgFRfdTEmpCG6H+FjDjDObakwpyG3
        RitK1EZiEzABSY10YmkWbV8=
X-Google-Smtp-Source: ABdhPJy1dM120uQA+EKT2yS9IT6DIj3C+mrVWhR93Zlr+6MjjeYL791K7lIDDt7XVcdg7XodQfrzIg==
X-Received: by 2002:a62:6586:0:b029:164:1cb9:8aff with SMTP id z128-20020a6265860000b02901641cb98affmr4488286pfb.64.1604711067997;
        Fri, 06 Nov 2020 17:04:27 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id o132sm3563997pfg.100.2020.11.06.17.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 17:04:26 -0800 (PST)
Subject: Re: [PATCH] RDMA/siw,rxe: Make emulated devices virtual in the device
 tree
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <yanjunz@nvidia.com>,
        "Pearson, Robert B" <robert.pearson2@hpe.com>
References: <0-v1-dcbfc68c4b4a+d6-virtual_dev_jgg@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <677434b0-7482-2a11-ae80-7f9f9563aad0@acm.org>
Date:   Fri, 6 Nov 2020 17:04:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <0-v1-dcbfc68c4b4a+d6-virtual_dev_jgg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/6/20 6:00 AM, Jason Gunthorpe wrote:
> This moves siw and rxe to be virtual devices in the device tree:
> 
> lrwxrwxrwx 1 root root 0 Nov  6 13:55 /sys/class/infiniband/rxe0 -> ../../devices/virtual/infiniband/rxe0/
> 
> Previously they were trying to parent themselves to the physical device of
> their attached netdev, which doesn't make alot of sense.
> 
> My hope is this will solve some weird syzkaller hits related to sysfs as
> it could be possible that the parent of a netdev is another netdev, eg
> under bonding or some other syzkaller found netdev configuration.
> 
> Nesting a ib_device under anything but a physical device is going to cause
> inconsistencies in sysfs during destructions.

Hi Jason,

I do not know enough about the code touched by this patch to comment on
the patch itself. But I expect that the blktests code will have to be
modified to compensate for this change. How to translate the name of a
virtual RDMA device into a netdev device with this patch applied?

From the blktests project:

# Check whether or not an rdma_rxe instance has been associated with
# network interface $1.
has_rdma_rxe() {
	local f

	for f in /sys/class/infiniband/*/parent; do
		if [ -e "$f" ] && [ "$(<"$f")" = "$1" ]; then
			return 0
		fi
	done

	return 1
}

rdma_dev_to_net_dev() {
	local b d rdma_dev=$1

	b=/sys/class/infiniband/$rdma_dev/parent
	if [ -e "$b" ]; then
		echo "$(<"$b")"
	else
		echo "${rdma_dev%_siw}"
	fi
}

Bart.
