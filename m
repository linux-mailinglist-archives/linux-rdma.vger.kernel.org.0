Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2CB32A80C
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Mar 2021 18:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhCBRAO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Mar 2021 12:00:14 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:46775 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbhCBEAM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Mar 2021 23:00:12 -0500
Received: by mail-pg1-f171.google.com with SMTP id h4so12961610pgf.13;
        Mon, 01 Mar 2021 19:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lIWzDiqoJEqo1Bg1QhNKMK2MRYP+ewMQz28y/3y4MQU=;
        b=hGEDou1ZolrwXnKNpmVmqOl9pNeY8LRJLCj3O6nKnytzrzW+8ynH8JnTfabm+0AkxL
         vlGlg1klsMMEF97aeGOXrwLmbUbvcD43Jlcu3NdhFJO+A3KSQf1eWCYdj/OXv1zET4ON
         C+EfQxenhJh4KVkkCUDyTLCNIh39BlaIsqGsjxgWVbzsc2pDIqPFsR8wcNuR/SvJOcVj
         ZhW98tFOvhftCSh9MSokP9HQ+J3FUqPeo8xeG3QqG6jl1QNxYjXgoxoC2C/ASEYIOdFh
         rYVZY+SdntkUloEFRJHVZBrwg2Jc3Zsf3mex+G9BgFB43mDCFt1EZ8s3RbMLL1Y2YpEw
         liHg==
X-Gm-Message-State: AOAM531nX/ivzXMRxqMlJDSp0i+OfiUttOnYTvn1tItx+5cgOPdBgkX/
        CD8KKPYDDWv5Ys1gZ2owP/4OkpolfQI=
X-Google-Smtp-Source: ABdhPJx1DOmeowL8c3tVPEhpocfYiDjRETOJnhQOgDjvcxCxsnWMnsyh4jpCyy17C9lLERVoGN8axA==
X-Received: by 2002:a63:5962:: with SMTP id j34mr16269769pgm.331.1614657563407;
        Mon, 01 Mar 2021 19:59:23 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:c6e8:5c02:da81:d405? ([2601:647:4000:d7:c6e8:5c02:da81:d405])
        by smtp.gmail.com with ESMTPSA id r202sm20492015pfc.10.2021.03.01.19.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 19:59:22 -0800 (PST)
Subject: Re: [bug report]null pointer at scsi_mq_exit_request+0x14 with
 blktests srp/015
To:     Yi Zhang <yi.zhang@redhat.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
References: <418155251.14154941.1614505772200.JavaMail.zimbra@redhat.com>
 <BYAPR04MB4965FDA9847096508E35FFB9869B9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <8b1fc0cd-196a-ad78-71c6-a7515ffbb4ad@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4d188158-3f18-c801-02ca-97350eb10c1b@acm.org>
Date:   Mon, 1 Mar 2021 19:59:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <8b1fc0cd-196a-ad78-71c6-a7515ffbb4ad@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/1/21 7:36 AM, Yi Zhang wrote:
> This issue cannot be reproduced on latest 5.12.0-rc1.
> 
> Please ignore this report, sorry for the noise.

How about rerunning the same test against v5.11.2, the latest v5.11
stable kernel? I think your report means that v5.11 can be improved...

Thanks,

Bart.
