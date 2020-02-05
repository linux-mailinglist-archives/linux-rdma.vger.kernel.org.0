Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE701538B6
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2020 20:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgBETHE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Feb 2020 14:07:04 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34711 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgBETHD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Feb 2020 14:07:03 -0500
Received: by mail-qk1-f194.google.com with SMTP id g3so2996473qka.1
        for <linux-rdma@vger.kernel.org>; Wed, 05 Feb 2020 11:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X5XddLc+LCm86tvUVR+1nIF87zwU+tlZedLNgKM3Uhs=;
        b=Aq+Ri81gK1F/phbI40icCfRb85KBPm9Kwp6mfZatjewDRjOMec95LVhrpQLf1Esx4J
         8yvmbn3FFu6rX9nTu/U86hTzY+SDdNLsjgrSlXzoGnFs7/V8/yoZ1qnFRjF3TlNxGKno
         SFGVAa2MjAfRu6MRO5SfK0Zyxo0UCqGPx8zk6GiC9QoOICdmTx6nX7W2eQsPCszOr734
         TRmQQqhSMUtZDY3K2NUKkpVFHRKXn5Le2+6wrwV3t4QUBfz4oxp0antWaUB68Y8NZ22A
         IozDWoHI4M4VZRKs64nLmz11daNQ/D3ai4thE7HvpcddxJkooWT2FPmXdgo6g9SRYLAx
         rXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X5XddLc+LCm86tvUVR+1nIF87zwU+tlZedLNgKM3Uhs=;
        b=iSUV0GDZ/v2E9Enf95uAbzASzvBoeTj6pGfFkft5cjAcsDXzW1lK4HatFU2M00dnq7
         68WQFZzicw+65Onix7QRZwtvrLpELKtHGbfxqn2k15LQSHwQVzEz3MwVYhvdytlsZIYe
         Pwc01sMGDpyoJpMvduZc2GGb9OzUQEHAATBVn7GNYeEIQlne6gLzGJZpoX47x097M8V4
         VdCD5QlAqLj1aa/ITJf7rW3Z4eNVlqLW82oBOtySyIWjEhUf0F5twNFmLNHR4J72O1v/
         z3EhXQN03f0sbPgJQn9fOsKIQYHRstjfJJ00grLYnLS5u2sGhuaNyfrzQOrm4+HcelZL
         xeWg==
X-Gm-Message-State: APjAAAWQ4WrixyAEDj5+U8ZeSlu+WkNefBTqA9SsYfiF7OzQt/EIpwm9
        GogNDK5mvSRJs80ZCh0lEXdRRA==
X-Google-Smtp-Source: APXvYqxAe77GNUr4O91XNP7wcDrqWKWbZI8fwuAbV+7He2WbUMUqjHK8eMacLQ9npARMP1Ip/JQ43A==
X-Received: by 2002:a05:620a:14a2:: with SMTP id x2mr35172951qkj.36.1580929622721;
        Wed, 05 Feb 2020 11:07:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w185sm284901qkb.45.2020.02.05.11.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2020 11:07:02 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1izQ0r-0004Pa-R8; Wed, 05 Feb 2020 15:07:01 -0400
Date:   Wed, 5 Feb 2020 15:07:01 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     Parav Pandit <parav@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH v6] libibverbs: display gid type in ibv_devinfo
Message-ID: <20200205190701.GD28298@ziepe.ca>
References: <1580809644-5979-1-git-send-email-devesh.sharma@broadcom.com>
 <AM0PR05MB4866F91551DAE20160D39235D1030@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <CANjDDBhY5EkJpk-_yv1gM76ZidLk92WHokq2nZFAUqOUH_Q-CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBhY5EkJpk-_yv1gM76ZidLk92WHokq2nZFAUqOUH_Q-CA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 04, 2020 at 08:56:54PM +0530, Devesh Sharma wrote:
> On Tue, Feb 4, 2020 at 8:01 PM Parav Pandit <parav@mellanox.com> wrote:
> >
> > Hi Devesh,
> >
> > > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > > owner@vger.kernel.org> On Behalf Of Devesh Sharma
> > >       phys_state:     LINK_UP (5)
> > >       GID[  0]:       fe80:0000:0000:0000:b226:28ff:fed3:b0f0, IB/RoCE v1
> > >       GID[  1]:       fe80:0000:0000:0000:b226:28ff:fed3:b0f0, RoCE v2
> > >       GID[  1]:       fe80::b226:28ff:fed3:b0f0
> > Showing two entries as individual raw like this is surely confusing to user.
> > Either all content should be in single raw or as Leon said just single different format for RoCEv2 is fine.
> Yes, I liked the single display in new format, I would wait for Jason
> to agree/disagree and then send a rev.

Well, I wasn't thinking to display the GID[xx] prefix for the 2nd
entry

It seems like other people want to just show one, that seems OK too

Jason
