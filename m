Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4B35BDFCD
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Sep 2022 10:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiITIVF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Sep 2022 04:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiITIUN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Sep 2022 04:20:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7A0B844
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 01:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663661914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nYBXnM221OKkMmYnX56agU4HA29O1+0qE07dmbgFr1Y=;
        b=F0OgTcmRQgV+Ch8wa63Iif3veP7AxynKLHbV79zgrraolhR+oDpdSGMZABtGOhz71Udllp
        9/cqc6NHBuE4WvXuHuepAwiPmqRWO4MRwY/MFSWh+7YpzdfaSb7AlD31hCh24ud/DuIayk
        n3f5z9hyD9GmZuEBubv5zcGJVBaxBak=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-588-A-_kUuW4MJiaMFGfkG1_9A-1; Tue, 20 Sep 2022 04:18:31 -0400
X-MC-Unique: A-_kUuW4MJiaMFGfkG1_9A-1
Received: by mail-wr1-f71.google.com with SMTP id d30-20020adfa41e000000b00228c0e80c49so831030wra.21
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 01:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nYBXnM221OKkMmYnX56agU4HA29O1+0qE07dmbgFr1Y=;
        b=knqSOnZwSBfK3/pN3ej8ATzvmaZQmgqfRMn1IP22rmvabby9xuS2blr7n4ObK+epoz
         +/a5/DWJ9EDg8CvIm5JOu0VRDfF5PkkZmR6HRtNzT2caT+Gl7uYxUK1rCQtL2fElvjfU
         zt6CzpkrxrFMxiBENqYfHS7ZQ1F99iS6Az2Ixi4M66YRsUkVqWWPmG+Kbrzg6PtcEAdG
         k5wms7yw/Hnb78V2UIdA051Gtcbfv3MfiNTHXgyc/oU/9ROYSNGZtFlpH4aRaLRMfUIs
         XtsAA9tghKbw5T78ll7rJp9hpk57CA1oAp+5aLOTJl7KNVKEeJ/o9tixYzz4wzO4Kjo2
         jjtA==
X-Gm-Message-State: ACrzQf1ynT4NUWIj7CP3y2zfNKt+c8kfXPimyiSs33V62rHHzzIwmxCP
        WPFLvbTF0K9/6GkK5wsUQf1gI/Vf/Xlz6TWuQdxskIOcUTtGmB39Tz41iMZN15FCT6Fh+hJJUV9
        Ah6pcK5QAGtFOJDXVptUGmw==
X-Received: by 2002:a5d:4ec5:0:b0:228:6707:8472 with SMTP id s5-20020a5d4ec5000000b0022867078472mr13700976wrv.12.1663661910617;
        Tue, 20 Sep 2022 01:18:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Gc746EtqOMp12PC/ZhI3qlffavJ9O8HKgnaDgO6702xNdn3VPX99CEZYZBDDZBLY3QzW+vw==
X-Received: by 2002:a5d:4ec5:0:b0:228:6707:8472 with SMTP id s5-20020a5d4ec5000000b0022867078472mr13700953wrv.12.1663661910369;
        Tue, 20 Sep 2022 01:18:30 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it. [87.11.6.69])
        by smtp.gmail.com with ESMTPSA id z22-20020a05600c0a1600b003b4868eb6bbsm1749112wmp.23.2022.09.20.01.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 01:18:29 -0700 (PDT)
Date:   Tue, 20 Sep 2022 10:18:24 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     vdasa@vmware.com, vbhakta@vmware.com, namit@vmware.com,
        bryantan@vmware.com, zackr@vmware.com,
        linux-graphics-maintainer@vmware.com, doshir@vmware.com,
        gregkh@linuxfoundation.org, davem@davemloft.net,
        pv-drivers@vmware.com, joe@perches.com, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 0/3] MAINTAINERS: Update entries for some VMware drivers
Message-ID: <20220920081824.vshwiv3lt5crlxdj@sgarzare-redhat>
References: <20220906172722.19862-1-vdasa@vmware.com>
 <20220919104147.1373eac1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220919104147.1373eac1@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 19, 2022 at 10:41:47AM -0700, Jakub Kicinski wrote:
>On Tue,  6 Sep 2022 10:27:19 -0700 vdasa@vmware.com wrote:
>> From: Vishnu Dasa <vdasa@vmware.com>
>>
>> This series updates a few existing maintainer entries for VMware
>> supported drivers and adds a new entry for vsock vmci transport
>> driver.
>
>Just to be sure - who are you expecting to take these in?
>

FYI Greg already queued this series in his char-misc-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/log/?h=char-misc-next

Thanks,
Stefano

