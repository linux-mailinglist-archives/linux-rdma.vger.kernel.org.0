Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1AE1CFEE8
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 22:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbgELUF2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 16:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbgELUF1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 May 2020 16:05:27 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C590C061A0E
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 13:05:27 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g185so15011530qke.7
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XYlu2eXcEyn79K9mTtWYUS4m2Il40SbRimfBXKFX27M=;
        b=K+ijg0oJH3pv2Az/ECO8+z9We7WNKV4Voe4Un+9P5f/I0xlNzZbZdLDRM6cbfWK8RT
         b0APuGzu0ul8VR7Xp9RRHiRoZK7p4taVlC/wQf9BZyHRZj1aZjkruJ5vfLkG68gOstHV
         FgIu/awKE/e5eO69XJ/hKc5iFbSvaznKNWWYXPls8liTGeJHNaTcjRNaBg9+wnfbFNRt
         YpBAFKESo57V7Z9bNw3LWSgcZWl7TlBcm9twfR1QhdRNrR86m+Q884nfDQ525Fb2BwXz
         TYWI9D8PJGsqqO54RacVN6WTSZJ0rOmr/3GnOTiQwIM4+CP+AePpXluipkSQJhL2GVkR
         K9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XYlu2eXcEyn79K9mTtWYUS4m2Il40SbRimfBXKFX27M=;
        b=pFeuWDYaxI3j/Cyp4Vy8cqA9E40u49HBV1cV+laMNBYOvgwAPblzPzoHAfZ959KyV6
         xcLSeU8/oJA1FF3/8unzhkKNKxLLUu29We/xQ+LdeThmo8Ak/iYU99dkLV3WUjaT7K+7
         IeoX/Rs7YHzB9W30UiSkj8XADoRA/+qVrDRCK40Gra9uNSlmyI1WWC++sN0eQDkJD21x
         ttt1/uiJsJOAdDZFS6Z1sJnovgthv1TVGd0zyQWrvU+phWB14qv8x/dMOSrvWs8uYIFr
         d1/ScGburBYRST0LGr71zJ6gQPVz5Y7eJiiELrA/7pGMvZNCqR7tfdtCh87yMoblphGY
         no5Q==
X-Gm-Message-State: AGi0PubLXitcaqYTzvmo9Zf8V4M8xNms/6NtHn4DeG4D0QYcbEUeAsf6
        fETRtn55aBYJrI3EACUu5FzCyTF1nqg=
X-Google-Smtp-Source: APiQypKmO+CbRnFPnWotv8sLpGTJhVbqzh1Y92d94um0xVgF995XQU3sHoppXt4OgsAO8ae2sbWjoA==
X-Received: by 2002:a37:4cd:: with SMTP id 196mr16812079qke.455.1589313926666;
        Tue, 12 May 2020 13:05:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g66sm8786521qkb.122.2020.05.12.13.05.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2020 13:05:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYb9Z-00040y-Or; Tue, 12 May 2020 17:05:25 -0300
Date:   Tue, 12 May 2020 17:05:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc 0/2] Fixes to IB_EVENT_DEVICE_FATAL logic
Message-ID: <20200512200525.GA15389@ziepe.ca>
References: <20200507063348.98713-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507063348.98713-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 07, 2020 at 09:33:46AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> Two changes, pretty straightforward.
> 
> Thanks
> 
> Jason Gunthorpe (2):
>   RDMA/uverbs: Do not discard the IB_EVENT_DEVICE_FATAL event
>   RDMA/uverbs: Move IB_EVENT_DEVICE_FATAL to destroy_uobj

Applied to for-rc

Jason
