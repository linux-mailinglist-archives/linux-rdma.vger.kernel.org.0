Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4170188418
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2019 22:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfHIUfE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Aug 2019 16:35:04 -0400
Received: from p3plsmtpa11-03.prod.phx3.secureserver.net ([68.178.252.104]:53849
        "EHLO p3plsmtpa11-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbfHIUfE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Aug 2019 16:35:04 -0400
Received: from [192.168.0.56] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id wBbIhReBmzUQUwBbIh7vF0; Fri, 09 Aug 2019 13:35:01 -0700
Subject: Re: [PATCH for-rc] siw: MPA Reply handler tries to read beyond MPA
 message
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Krishnamraju Eraparaju <krishna2@chelsio.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
References: <9c4c1ee1-11ed-0572-4381-2915407b2bb7@talpey.com>
 <20190808164638.GA7795@chelsio.com> <20190805172605.GA5549@chelsio.com>
 <8499b96a-48dd-1286-ea0f-e66be34afffa@talpey.com>
 <20190731103310.23199-1-krishna2@chelsio.com>
 <OF4DB6F345.7C76F976-ON00258449.00392FF3-00258449.003C1BFB@notes.na.collabserv.com>
 <OF95C29EF7.244FC9E1-ON0025844A.003D049F-0025844A.003E229B@notes.na.collabserv.com>
 <518b1734-5d72-e32d-376b-0fec1cbce8f5@talpey.com>
 <OF7F439620.B43AE37C-ON00258450.00524237-00258450.0052DFDC@notes.na.collabserv.com>
 <OF5309F939.D7FB77B5-ON00258451.002EE699-00258451.0039A86F@notes.na.collabserv.com>
 <OF748C7EEE.1CA3CB7C-ON00258451.004B1A16-00258451.004C38AC@notes.na.collabserv.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <1043a512-68c6-c263-7589-5da4b9a9e282@talpey.com>
Date:   Fri, 9 Aug 2019 16:35:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <OF748C7EEE.1CA3CB7C-ON00258451.004B1A16-00258451.004C38AC@notes.na.collabserv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBRf8CR2URMIWV7CryQXo0xVRH+SMMuXkFSMU+z9N3poKpGFXfFkChJG9K8m3L+KiFav5jSsfLurVuX7akXb8bgqRzaVeR7UPcvXhPpwYXSjq/L8vpBs
 koNDeqTIDb3Hza147AzSgwrGHZoKvzQdogh9nxkuSLAlnXYBGs0Aa6fOrMjhqRmuM4LOtoeGpmr5Je5RX7TOq8FumsADTheRaqDlD53EShBw+lL2bG6KGned
 74tX+08fd8NkVz7NSNqxz/oMnB5EUmZfWk+p2VvGnNU0NLiwwZas3/MWO2XAMPd4XajlOWRiCxukmzBD5VZcFg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/9/2019 9:52 AM, Bernard Metzler wrote:
> -----"Tom Talpey" <tom@talpey.com> wrote: -----
> 
>> To: "Bernard Metzler" <BMT@zurich.ibm.com>, "Krishnamraju Eraparaju"
>> <krishna2@chelsio.com>
>> From: "Tom Talpey" <tom@talpey.com>
>> Date: 08/09/2019 02:27PM
>> Cc: "jgg@ziepe.ca" <jgg@ziepe.ca>, "linux-rdma@vger.kernel.org"
>> <linux-rdma@vger.kernel.org>, "Potnuri Bharat Teja"
>> <bharat@chelsio.com>, "Nirranjan Kirubaharan" <nirranjan@chelsio.com>
>> Subject: [EXTERNAL] Re: [PATCH for-rc] siw: MPA Reply handler tries
>> to read beyond MPA message
>>
>> On 8/9/2019 6:29 AM, Bernard Metzler wrote:
>>> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
>>>
>>>> To: "Bernard Metzler" <BMT@zurich.ibm.com>
>>>> From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>>>> Date: 08/08/2019 06:47PM
>>>> Cc: "Tom Talpey" <tom@talpey.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
>>>> "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
>> "Potnuri
>>>> Bharat Teja" <bharat@chelsio.com>, "Nirranjan Kirubaharan"
>>>> <nirranjan@chelsio.com>
>>>> Subject: [EXTERNAL] Re: [PATCH for-rc] siw: MPA Reply handler
>> tries
>>>> to read beyond MPA message
>>>>
>>>> On Thursday, August 08/08/19, 2019 at 15:05:12 +0000, Bernard
>> Metzler
>>>> wrote:
>>>>> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
>>>>>
>>>>>> To: "Tom Talpey" <tom@talpey.com>, <BMT@zurich.ibm.com>
>>>>>> From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>>>>>> Date: 08/05/2019 07:26PM
>>>>>> Cc: "jgg@ziepe.ca" <jgg@ziepe.ca>, "linux-rdma@vger.kernel.org"
>>>>>> <linux-rdma@vger.kernel.org>, "Potnuri Bharat Teja"
>>>>>> <bharat@chelsio.com>, "Nirranjan Kirubaharan"
>>>> <nirranjan@chelsio.com>
>>>>>> Subject: [EXTERNAL] Re: [PATCH for-rc] siw: MPA Reply handler
>>>> tries
>>>>>> to read beyond MPA message
>>>>>>
>>>>>> On Friday, August 08/02/19, 2019 at 18:17:37 +0530, Tom Talpey
>>>> wrote:
>>>>>>> On 8/2/2019 7:18 AM, Bernard Metzler wrote:
>>>>>>>> -----"Tom Talpey" <tom@talpey.com> wrote: -----
>>>>>>>>
>>>>>>>>> To: "Bernard Metzler" <BMT@zurich.ibm.com>, "Krishnamraju
>>>>>> Eraparaju"
>>>>>>>>> <krishna2@chelsio.com>
>>>>>>>>> From: "Tom Talpey" <tom@talpey.com>
>>>>>>>>> Date: 08/01/2019 08:54PM
>>>>>>>>> Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
>>>>>> bharat@chelsio.com,
>>>>>>>>> nirranjan@chelsio.com, krishn2@chelsio.com
>>>>>>>>> Subject: [EXTERNAL] Re: [PATCH for-rc] siw: MPA Reply handler
>>>>>> tries
>>>>>>>>> to read beyond MPA message
>>>>>>>>>
>>>>>>>>> On 8/1/2019 6:56 AM, Bernard Metzler wrote:
>>>>>>>>>> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote:
>>>>>> -----
>>>>>>>>>>
>>>>>>>>>>> To: jgg@ziepe.ca, bmt@zurich.ibm.com
>>>>>>>>>>> From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>>>>>>>>>>> Date: 07/31/2019 12:34PM
>>>>>>>>>>> Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com,
>>>>>>>>>>> nirranjan@chelsio.com, krishn2@chelsio.com, "Krishnamraju
>>>>>>>>> Eraparaju"
>>>>>>>>>>> <krishna2@chelsio.com>
>>>>>>>>>>> Subject: [EXTERNAL] [PATCH for-rc] siw: MPA Reply handler
>>>>>> tries to
>>>>>>>>>>> read beyond MPA message
>>>>>>>>>>>
>>>>>>>>>>> while processing MPA Reply, SIW driver is trying to read
>>>> extra
>>>>>> 4
>>>>>>>>>>> bytes
>>>>>>>>>>> than what peer has advertised as private data length.
>>>>>>>>>>>
>>>>>>>>>>> If a FPDU data is received before even siw_recv_mpa_rr()
>>>>>> completed
>>>>>>>>>>> reading MPA reply, then ksock_recv() in siw_recv_mpa_rr()
>>>>>> could
>>>>>>>>> also
>>>>>>>>>>> read FPDU, if "size" is larger than advertised MPA reply
>>>>>> length.
>>>>>>>>>>>
>>>>>>>>>>> 501 static int siw_recv_mpa_rr(struct siw_cep *cep)
>>>>>>>>>>> 502 {
>>>>>>>>>>>              .............
>>>>>>>>>>> 572
>>>>>>>>>>> 573         if (rcvd > to_rcv)
>>>>>>>>>>> 574                 return -EPROTO;   <----- Failure here
>>>>>>>>>>>
>>>>>>>>>>> Looks like the intention here is to throw an ERROR if the
>>>>>> received
>>>>>>>>>>> data
>>>>>>>>>>> is more than the total private data length advertised by
>>>> the
>>>>>> peer.
>>>>>>>>>>> But
>>>>>>>>>>> reading beyond MPA message causes siw_cm to generate
>>>>>>>>>>> RDMA_CM_EVENT_CONNECT_ERROR event when TCP socket recv
>>>> buffer
>>>>>> is
>>>>>>>>>>> already
>>>>>>>>>>> queued with FPDU messages.
>>>>>>>>>>>
>>>>>>>>>>> Hence, this function should only read upto private data
>>>>>> length.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Krishnamraju Eraparaju
>>>> <krishna2@chelsio.com>
>>>>>>>>>>> ---
>>>>>>>>>>> drivers/infiniband/sw/siw/siw_cm.c | 4 ++--
>>>>>>>>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>>>>>>>>>>> b/drivers/infiniband/sw/siw/siw_cm.c
>>>>>>>>>>> index a7cde98e73e8..8dc8cea2566c 100644
>>>>>>>>>>> --- a/drivers/infiniband/sw/siw/siw_cm.c
>>>>>>>>>>> +++ b/drivers/infiniband/sw/siw/siw_cm.c
>>>>>>>>>>> @@ -559,13 +559,13 @@ static int siw_recv_mpa_rr(struct
>>>>>> siw_cep
>>>>>>>>> *cep)
>>>>>>>>>>> 	 * A private data buffer gets allocated if
>>>> hdr->params.pd_len
>>>>>> !=
>>>>>>>>> 0.
>>>>>>>>>>> 	 */
>>>>>>>>>>> 	if (!cep->mpa.pdata) {
>>>>>>>>>>> -		cep->mpa.pdata = kmalloc(pd_len + 4, GFP_KERNEL);
>>>>>>>>>>> +		cep->mpa.pdata = kmalloc(pd_len, GFP_KERNEL);
>>>>>>>>>>> 		if (!cep->mpa.pdata)
>>>>>>>>>>> 			return -ENOMEM;
>>>>>>>>>>> 	}
>>>>>>>>>>> 	rcvd = ksock_recv(
>>>>>>>>>>> 		s, cep->mpa.pdata + cep->mpa.bytes_rcvd - sizeof(struct
>>>>>> mpa_rr),
>>>>>>>>>>> -		to_rcv + 4, MSG_DONTWAIT);
>>>>>>>>>>> +		to_rcv, MSG_DONTWAIT);
>>>>>>>>>>>
>>>>>>>>>>> 	if (rcvd < 0)
>>>>>>>>>>> 		return rcvd;
>>>>>>>>>>> -- 
>>>>>>>>>>> 2.23.0.rc0
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> The intention of this code is to make sure the
>>>>>>>>>> peer does not violates the MPA handshake rules.
>>>>>>>>>> The initiator MUST NOT send extra data after its
>>>>>>>>>> MPA request and before receiving the MPA reply.
>>>>>>>>>
>>>>>>>>> I think this is true only for MPA v2. With MPA v1, the
>>>>>>>>> initiator can begin sending immediately (before receiving
>>>>>>>>> the MPA reply), because there is no actual negotiation at
>>>>>>>>> the MPA layer.
>>>>>>>>>
>>>>>>>>> With MPA v2, the negotiation exchange is required because
>>>>>>>>> the type of the following message is predicated by the
>>>>>>>>> "Enhanced mode" a|b|c|d flags present in the first 32 bits
>>>>>>>>> of the private data buffer.
>>>>>>>>>
>>>>>>>>> So, it seems to me that additional logic is needed here to
>>>>>>>>> determine the MPA version, before sniffing additional octets
>>>>>>>> >from the incoming stream?
>>>>>>>>>
>>>>>>>>> Tom.
>>>>>>>>>
>>>>>>>>
>>>>>>>> There still is the marker negotiation taking place.
>>>>>>>> RFC 5044 says in section 7.1.2:
>>>>>>>>
>>>>>>>> "Note: Since the receiver's ability to deal with Markers is
>>>>>>>>     unknown until the Request and Reply Frames have been
>>>>>>>>     received, sending FPDUs before this occurs is not
>> possible."
>>>>>>>>
>>>>>>>> This section further discusses the responder's behavior,
>>>>>>>> where it MUST receive a first FPDU from the initiator
>>>>>>>> before sending its first FPDU:
>>>>>>>>
>>>>>>>> "4.  MPA Responder mode implementations MUST receive and
>>>> validate
>>>>>> at
>>>>>>>>           least one FPDU before sending any FPDUs or Markers."
>>>>>>>>
>>>>>>>> So it appears with MPA version 1, the current siw
>>>>>>>> code is correct. The initiator is entering FPDU mode
>>>>>>>> first, and only after receiving the MPA reply frame.
>>>>>>>> Only after the initiator sent a first FPDU, the responder
>>>>>>>> can start using the connection in FPDU mode.
>>>>>>>> Because of this somehow broken connection establishment
>>>>>>>> procedure (only the initiator can start sending data), a
>>>>>>>> later MPA version makes this first FPDU exchange explicit
>>>>>>>> and selectable (zero length READ/WRITE/Send).
>>>>>>>
>>>>>>> Yeah, I guess so. Because nobody ever actually implemented
>>>> markers,
>>>>>>> I think that they may more or less passively ignore this. But
>>>>>> you're
>>>>>>> currect that it's invalid protocol behavior.
>>>>>>>
>>>>>>> If your testing didn't uncover any issues with existing
>>>>>> implementations
>>>>>>> failing to connect with your strict checking, I'm ok with it.
>>>>>> Tom & Bernard,
>>>>>> Thanks for the insight on MPA negotiation.
>>>>>>
>>>>>> Could the below patch be considered as a proper fix?
>>>>>>
>>>>>> diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>>>>>> b/drivers/infiniband/sw/siw/siw_cm.c
>>>>>> index 9ce8a1b925d2..0aec1b5212f9 100644
>>>>>> --- a/drivers/infiniband/sw/siw/siw_cm.c
>>>>>> +++ b/drivers/infiniband/sw/siw/siw_cm.c
>>>>>> @@ -503,6 +503,7 @@ static int siw_recv_mpa_rr(struct siw_cep
>>>> *cep)
>>>>>>          struct socket *s = cep->sock;
>>>>>>          u16 pd_len;
>>>>>>          int rcvd, to_rcv;
>>>>>> +       int extra_data_check = 4; /* 4Bytes, for MPA rules
>>>> violation
>>>>>> checking */
>>>>>>
>>>>>>          if (cep->mpa.bytes_rcvd < sizeof(struct mpa_rr)) {
>>>>>>                  rcvd = ksock_recv(s, (char *)hdr +
>>>>>> cep->mpa.bytes_rcvd,
>>>>>> @@ -553,23 +554,37 @@ static int siw_recv_mpa_rr(struct siw_cep
>>>> *cep)
>>>>>>                  return -EPROTO;
>>>>>>          }
>>>>>>
>>>>>> +       /*
>>>>>> +        * Peer must not send any extra data other than MPA
>>>> messages
>>>>>> until MPA
>>>>>> +        * negotiation is completed, an exception is MPA V2
>>>>>> client-server Mode,
>>>>>> +        * IE, in this mode the peer after sending MPA Reply can
>>>>>> immediately
>>>>>> +        * start sending data in RDMA mode.
>>>>>> +        */
>>>>>
>>>>> This is unfortunately not true. The responder NEVER sends
>>>>> an FPDU without having seen an FPDU from the initiator.
>>>>> I just checked RFC 6581 again. The RTR (ready-to-receive)
>>>>> indication from the initiator is still needed, but now
>>>>> provided by the protocol and not the application: w/o
>>>>> 'enhanced MPA setup', the initiator sends the first
>>>>> FPDU as an application message. With 'enhanced MPA setup',
>>>>> the initiator protocol entity sends (w/o application
>>>>> interaction) a zero length READ/WRITE/Send as a first FPDU,
>>>>> as previously negotiated with the responder. Again: only
>>>>> after the responder has seen the first FPDU, it can
>>>>> start sending in FPDU mode.
>>>> If I understand your statements correctly: in MPA v2 clint-server
>>>> mode,
>>>> the responder application should have some logic to wait(after
>>>> ESTABLISH
>>>> event) until the first FPDU message is received from the
>> initiator?
>>>>
>>>> Thanks,
>>>> Krishna.
>>>
>>> The responder may either delay the established event
>>> until it sees the first peer FPDU, or it delays sending
>>> the first (now already posted) FPDU, until it sees the
>>> first initiator FPDU. This, since (theoretically), the
>>> responder does not know yet the result of CRC and
>>> Marker negotiation. siw delays the established event,
>>> which seems the more clear path to me.
>>>
>>> This MPA handshake is cumbersome. siw is permissive
>>> for violations of these rules to the extend, that the
>>> responder shall not send back to back the first FPDU
>>> with the MPA reply. If a (Chelsio ?) iWarp adapter
>>> would send the first responder FPDU only after it
>>> got TCP acked its MPA reply, the chances are high the
>>> (siw) iWarp initiator has already transitioned to RTS
>>> and it would accept that FPU, even if not having sent
>>> it's first FPDU.
>>>
>>> siw sticks to this rule to that extend, since all receive
>>> processing is triggered by socket callbacks (from
>>> sk->sk_data_ready()). As long as the QP is not
>>> in RTS, all TCP bytestream processing is done by the
>>> MPA protocol (code in siw_cm.c). If the QP reaches
>>> RTS, RX processing is done bt the full iWarp
>>> protocol (code in siw_qp_rx.c for RX).
>>> Now, if the higher layer (application) protocol has
>>> a semantic where the responder sends the first message,
>>> we could end up in an infinite wait for that packet
>>> at initiator application side.
>>> This, since the complete first FPDU was already
>>> received at the TCP socket, while the QP was not in
>>> RTS. It will not trigger any additional sk->sk_data_ready()
>>> and we are stuck with a FPDU in the socket rx buffer.
>>>
>>> I implemented that 4 bytes extra data testing only to
>>> keep the siw protocol state machine as simple as
>>> possible (it is already unfortunately complex, if
>>> you count the lines in siw_cm.c), while following
>>> the protocol rules.
>>>
>>> I suggest to correctly implement peer2peer mode and
>>> delay the established event at the responder side until
>>> it got the negotiated first zero length FPDU. Out
>>> of the possible options, siw supports both zero length
>>> WRITE and READ, but no SEND, since this would consume
>>> an extra receive WQE.
>>>
>>> As a last resort, I might consider extending the
>>> siw state machine to handle those - non-complaint -
>>> cases gracefully. But, that would result in different
>>> code than just avoiding checking for peer protocol
>>> violation.
>>
>> Bernard, everything you describe in siw seems perfectly valid
>> to me, and in fact that's why the MPA enhanced connection mode
>> was designed the way it is. I disagree that it's "cumbersome",
>> but that's a nit.
>>
>> The issue is that the responder reaches RTS at a different time
>> than the initiator reaches RTR. The original iWARP connection
>> model did not make any requirement, and races were possible.
>> MPAv2 fixes those.
>>
> Tom, thanks, exactly. MPAv2 fixes it. And an implementation
> of that fix MUST adhere to the defined rules. If one
> negotiates an extra handshake to synchronize, it
> MUST adhere to that handshake rules. There is no point in
> negotiating an extra handshake, and right away ignoring it.
> If the responder wants a zero length WRITE, it MUST use
> its reception to synchronize its transition to RTS.
> 
> Shall we extend the siw state machine to support silly
> peer behavior? As said, if I read there is no way of

Of course the right answer to this is "no", but I'd reserve
drawing that conclusion until I am certain it won't cause
trouble. If existing iWARP implementations don't enforce
this, and SIW becomes the odd duck failing connections, then
I'm afraid I would have to say "yes" instead.

> making the peer implementation RFC compliant (it would
> be unexpected), I'll look into the applicability of
> Postel's Rule. But let's make those things explicit.

Explicit is best, agreed.

Tom.

> 
>> SIW is certainly within its rights to prevent peers from
>> sending prior to responder RTR. I'd suggest that if possible,
>> you try to detect the deadlock rather than flatly rejecting any
>> incoming bytes. The Internet Principle (be liberal in what you
>> accept...), after all.
>>
>> This same dance happens in IB/RoCE, btw. Just via different
>> messages.
>>
> Interesting!
> 
> Thanks
> Bernard.
> 
>> Tom.
>>
>>
>>>
>>> Thanks,
>>> Bernard.
>>>
>>>
>>>>>
>>>>> Sorry for the confusion. But the current
>>>>> siw code appears to be just correct.
>>>>>
>>>>> Thanks
>>>>> Bernard
>>>>>
>>>>>
>>>>>
>>>>>> +       if ((__mpa_rr_revision(cep->mpa.hdr.params.bits) ==
>>>>>> MPA_REVISION_2) &&
>>>>>> +               (cep->state == SIW_EPSTATE_AWAIT_MPAREP)) {
>>>>>> +               int mpa_p2p_mode = cep->mpa.v2_ctrl_req.ord &
>>>>>> +                               (MPA_V2_RDMA_WRITE_RTR |
>>>>>> MPA_V2_RDMA_READ_RTR);
>>>>>> +               if (!mpa_p2p_mode)
>>>>>> +                       extra_data_check = 0;
>>>>>> +       }
>>>>>> +
>>>>>>          /*
>>>>>>           * At this point, we must have hdr->params.pd_len != 0.
>>>>>>           * A private data buffer gets allocated if
>>>> hdr->params.pd_len
>>>>>> !=
>>>>>>           * 0.
>>>>>>           */
>>>>>>          if (!cep->mpa.pdata) {
>>>>>> -               cep->mpa.pdata = kmalloc(pd_len + 4,
>> GFP_KERNEL);
>>>>>> +               cep->mpa.pdata = kmalloc(pd_len +
>>>> extra_data_check,
>>>>>> GFP_KERNEL);
>>>>>>                  if (!cep->mpa.pdata)
>>>>>>                          return -ENOMEM;
>>>>>>          }
>>>>>>          rcvd = ksock_recv(
>>>>>>                  s, cep->mpa.pdata + cep->mpa.bytes_rcvd -
>>>>>> sizeof(struct
>>>>>> mpa_rr),
>>>>>> -               to_rcv + 4, MSG_DONTWAIT);
>>>>>> +               to_rcv + extra_data_check, MSG_DONTWAIT);
>>>>>>
>>>>>>          if (rcvd < 0)
>>>>>>                  return rcvd;
>>>>>>
>>>>>> -       if (rcvd > to_rcv)
>>>>>> +       if (extra_data_check && (rcvd > to_rcv))
>>>>>>                  return -EPROTO;
>>>>>>
>>>>>>          cep->mpa.bytes_rcvd += rcvd;
>>>>>>
>>>>>> -Krishna.
>>>>>>>
>>>>>>> Tom.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Bernard.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> So, for the MPA request case, this code is needed
>>>>>>>>>> to check for protocol correctness.
>>>>>>>>>> You are right for the MPA reply case - if we are
>>>>>>>>>> _not_ in peer2peer mode, the peer can immediately
>>>>>>>>>> start sending data in RDMA mode after its MPA Reply.
>>>>>>>>>> So we shall add appropriate code to be more specific
>>>>>>>>>> For an error, we are (1) processing an MPA Request,
>>>>>>>>>> OR (2) processing an MPA Reply AND we are not expected
>>>>>>>>>> to send an initial READ/WRITE/Send as negotiated with
>>>>>>>>>> the peer (peer2peer mode MPA handshake).
>>>>>>>>>>
>>>>>>>>>> Just removing this check would make siw more permissive,
>>>>>>>>>> but to a point where peer MPA protocol errors are
>>>>>>>>>> tolerated. I am not in favor of that level of
>>>>>>>>>> forgiveness.
>>>>>>>>>>
>>>>>>>>>> If possible, please provide an appropriate patch
>>>>>>>>>> or (if it causes current issues with another peer
>>>>>>>>>> iWarp implementation) just run in MPA peer2peer mode,
>>>>>>>>>> where the current check is appropriate.
>>>>>>>>>> Otherwise, I would provide an appropriate fix by Monday
>>>>>>>>>> (I am still out of office this week).
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Many thanks and best regards,
>>>>>>>>>> Bernard.
>>>>>>>>>>
>>
>>
> 
> 
> 
