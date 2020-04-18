Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786091AF5E5
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Apr 2020 01:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgDRXe4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Apr 2020 19:34:56 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:38520 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgDRXe4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 18 Apr 2020 19:34:56 -0400
Received: by mail-pj1-f48.google.com with SMTP id t40so2796700pjb.3;
        Sat, 18 Apr 2020 16:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l3Cgp4ObnKqtcXsQ9rv+7rU/gMp6xiQLvsCKNRWhXxo=;
        b=hu4Ho/nl9/99ItbMBxEUJIp1FnLZG3csIiBCNrQfv+YnFrTnO1sIGg++WuT4AyHO/F
         CtBm4h4QwT3mx1dJRPR5DW/NJIerQ20SvU3WevYsWXmlOSkGX4fgqLGLHyrpLR5dMMXJ
         EUvMc1xLOPqxtxXIkoRdJOgCQ0jAymOibR3pBhgVXZ59O0LJQRLpQXMAkjEwuBRinG9K
         MeFH3gMwjhmvMbbJQbnrLWok42QBICILvcWrMLk/0PiDuxR6aZgbqLowFNRc2BJz2eSg
         seE7btqI1PR9/0ktqjGjVkKVf6V/3THkyjSK13fallu3YX0OVD9ipM70O/eVudn0wAqT
         px7A==
X-Gm-Message-State: AGi0PuY5hf0MVWgrsHtAPI6dLq4uOQEtAyBjI4AANj9AYPzLTSffn76k
        08JCSM8iOgt9Z1hWO4AkPPc=
X-Google-Smtp-Source: APiQypJSINfTHXfIUM0I2fynKWVaeyYoUIozINIgs7HIXUixqW4HnCxv1dfwnwaYyxj8yk6QlgsKkA==
X-Received: by 2002:a17:90b:4d0b:: with SMTP id mw11mr12968539pjb.45.1587252894080;
        Sat, 18 Apr 2020 16:34:54 -0700 (PDT)
Received: from [100.124.15.238] ([104.129.199.8])
        by smtp.gmail.com with ESMTPSA id ep21sm9138486pjb.24.2020.04.18.16.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 16:34:53 -0700 (PDT)
Subject: Re: [PATCH v12 20/25] block/rnbd: server: main functionality
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <20200415092045.4729-21-danil.kipnis@cloud.ionos.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e6c0d434-2dac-4a41-912b-bf09d5d98a0c@acm.org>
Date:   Sat, 18 Apr 2020 16:34:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415092045.4729-21-danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/15/20 2:20 AM, Danil Kipnis wrote:
> This is main functionality of rnbd-server module, which handles RTRS
> events and rnbd protocol requests, like map (open) or unmap (close)
> device.  Also server side is responsible for processing incoming IBTRS
> IO requests and forward them to local mapped devices.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

